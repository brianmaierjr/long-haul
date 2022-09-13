require 'stringio'
require 'tempfile'
require 'strscan'

module Http
  # This is a native ruby implementation of the http parser. It is also
  # the reference implementation for this library. Later there will be one
  # written in C for performance reasons, and it will have to pass the same
  # specs as this one.
  class NativeParser
    # The HTTP method string used. Will always be a string and all-capsed.
    # Valid values are: "GET", "HEAD", "POST", "PUT", "DELETE".
    # Other values will cause an exception since then we don't know
    # whether the request has a body.
    attr_reader :method
    
    # The path given by the client as a string. No processing is done on
    # this and nearly anything is considered valid.
    attr_reader :path
    
    # The HTTP version of the request as an array of two integers.
    # [1,0] and [1,1] are the most likely values currently.
    attr_reader :version
    
    # A hash of headers passed to the server with the request. All
    # headers will be normalized to ALLCAPS_WITH_UNDERSCORES for
    # consistency's sake.
    attr_reader :headers
    
    # The body of the request as a stream object. May be either
    # a StringIO or a TempFile, depending on request length.
    attr_reader :body
    
    # The default set of parse options for the request.
    DefaultOptions = {
      # maximum length of an individual header line.
      :max_header_length => 10240, 
      # maximum number of headers that can be passed to the server
      :max_headers => 100,
      # the size of the request body before it will be spilled
      # to a tempfile instead of being stored in memory.
      :min_tempfile_size => 1048576,
      # the class to use to create and manage the temporary file.
      # Must conform to the same interface as the stdlib Tempfile class
      :tempfile_class => Tempfile,
    }

    # Constants for method information
    MethodInfo = Struct.new(:must_have_body, :can_have_body)
    Methods = {
      "OPTIONS" => MethodInfo[false, true],
      "GET" => MethodInfo[false, false],
      "HEAD" => MethodInfo[false, false],
      "POST" => MethodInfo[true, true],
      "PUT" => MethodInfo[true, true],
      "DELETE" => MethodInfo[false, false],
      "TRACE" => MethodInfo[false, false],
      "CONNECT" => MethodInfo[false, false],
    }
    
    # Regex used to match the Request-Line
    RequestLineMatch = %r{^([a-zA-Z]+) (.+) HTTP/([0-9]+)\.([0-9]+)\r?\n}
    # Regex used to match a header line. Lines suspected of
    # being headers are also checked against the HeaderContinueMatch
    # to deal with multiline headers
    HeaderLineMatch = %r{^([a-zA-Z-]+):[ \t]*([[:print:]]+?)\r?\n}
    HeaderContinueMatch = %r{^[ \t]+([[:print:]]+?)\r?\n}
    EmptyLineMatch = %r{^\r?\n}
    
    # Regex used to match a size specification for a chunked segment
    ChunkSizeLineMatch = %r{^[0-9a-fA-F]+\r?\n}
    
    # Used as a fallback in error detection for a malformed request line or header.
    AnyLineMatch = %r{^.+?\r?\n}
        
    def initialize(options = DefaultOptions)
      @method = nil
      @path = nil
      @version = nil
      @headers = {}
      @body = nil
      @state = :request_line
      @options = DefaultOptions.merge(options)
    end
    
    # Returns true if the http method being parsed (if
    # known at this point in the parse) must have a body.
    # If the method hasn't been determined yet, returns false.
    def must_have_body?
      Methods[@method].must_have_body
    end
    
    # Returns true if the http method being parsed (if
    # known at this point in the parse) can have a body.
    # If the method hasn't been determined yet, returns false.
    def can_have_body?
      Methods[@method].can_have_body
    end
    
    # Returns true if the request has a body.
    def has_body?
      @body
    end
    
    # Takes a string and runs it through the parser. Note that
    # it does not consume anything it can't completely parse, so
    # you should always pass complete request chunks (lines or body data)
    # to this method. It's mostly for testing and convenience.
    # In practical use, you want to use parse!, which will remove parsed
    # data from the string you pass in.
    def parse(str)
      parse!(str.dup)
    end
    
    def parse_request_line(scanner)
      if (scanner.scan(RequestLineMatch))
        @method = scanner[1]
        @path = scanner[2]
        @version = [scanner[3].to_i, scanner[4].to_i]
    
        @state = :headers
        
        if (!Methods[@method])
          raise Http::ParserError::NotImplemented
        end
      elsif (scanner.scan(EmptyLineMatch))
        # ignore an empty line before a request line.
      elsif (scanner.scan(AnyLineMatch))
        raise Http::ParserError::BadRequest
      end
    end
    private :parse_request_line
    
    def parse_headers(scanner)
      if (scanner.scan(HeaderLineMatch))
        header = normalize_header(scanner[1])
        if (@headers[header])
          @headers[header] << "," << scanner[2]
        else
          @headers[header] = scanner[2]
        end
        @last_header = header
      elsif (@last_header && scanner.scan(HeaderContinueMatch))
        @headers[@last_header] << " " << scanner[1]
      elsif (scanner.scan(EmptyLineMatch))
        req_has_body = @headers["CONTENT_LENGTH"] || @headers["TRANSFER_ENCODING"]
        if (req_has_body)
          if (@headers["TRANSFER_ENCODING"] && @headers["TRANSFER_ENCODING"] != 'identity')
            @state = :body_chunked
            @body_length = 0 # this will get updated as we go.
            @body_read = 0
            @chunk_remain = nil
          elsif (@headers["CONTENT_LENGTH"])
            @body_length = @headers["CONTENT_LENGTH"].to_i
            @body_read = 0
            if (@body_length > 0)
              @state = :body_identity
            else
              @state = :done
            end
          end
          
          if (can_have_body?)
            if (@body_length >= @options[:min_tempfile_size])
              @body = @options[:tempfile_class].new("http_parser")
              File.unlink(@body.to_path) rescue nil # ruby 1.9.1 does Tempfile.unlink wrong, so we do it ourselves.
            else
              @body = StringIO.new
            end
          else
            @body = nil
          end
        else
          if (must_have_body?)
            # we assume it has a body and the client just didn't tell us
            # how big it was. This is more useful than BadRequest.
            raise ParserError::LengthRequired
          else
            @state = :done
          end
        end
      elsif (scanner.scan(AnyLineMatch))
        raise Http::ParserError::BadRequest
      end  
    end
    private :parse_headers
    
    def parse_body_identity(scanner)
      remain = @body_length - @body_read
      addition = scanner.string[scanner.pos, remain]
      scanner.pos += addition.length
      @body_read += addition.length

      @body << addition if @body
      
      if (@body_read >= @body_length)
        @body.rewind if (@body)
        @state = :done
      end
    end
    private :parse_body_identity
    
    def parse_body_chunked(scanner)
      if (@chunk_remain)
        if (@chunk_remain > 0)
          addition = scanner.string[scanner.pos, @chunk_remain]
          scanner.pos += addition.length
          @chunk_remain -= addition.length
          @body_length += addition.length
        
          @body << addition if @body
          
          if (@body.length >= @options[:min_tempfile_size] && @body.kind_of?(StringIO))
            @body_str = @body.string
            @body = @options[:tempfile_class].new("http_parser")
            File.unlink(@body.to_path) rescue nil # ruby 1.9.1 does Tempfile.unlink wrong, so we do it ourselves.
            @body << @body_str
          end
        else
          if (scanner.scan(EmptyLineMatch))
            # the chunk is done.
            @chunk_remain = nil
          elsif (scanner.scan(AnyLineMatch))
            # there was a line with stuff in it,
            # which is invalid here.
            raise ParserError::BadRequest
          end
        end
      elsif (scanner.scan(ChunkSizeLineMatch))
        @chunk_remain = scanner[0].to_i(16)
        if (@chunk_remain < 1)
          @state = :body_chunked_tail
        end
      elsif (scanner.scan(AnyLineMatch))
        raise ParserError::BadRequest
      end
    end
    private :parse_body_chunked
    
    def parse_body_chunked_tail(scanner)
      # It's not actually clear if tail headers are even
      # legal in a chunked request entity. The docs seem
      # to indicate that they should only be sent if the other
      # end is known to accept them, and there's no way to ensure
      # that when the client is the originator. As such, we'll
      # just ignore them for now. We'll do this by ignoring
      # any line until we hit an empty line, which will be treated
      # as the end of the entity.
      if (scanner.scan(EmptyLineMatch))
        @state = :done
        @body.rewind
      elsif (scanner.scan(AnyLineMatch))
        # ignore the line.
      end
    end
    private :parse_body_chunked_tail
    
    def parse_done(scanner)
      # do nothing, the parse is done.
    end
    private :parse_done
    
    # Consumes as much of str as it can and then removes it from str. This
    # allows you to iteratively pass data into the parser as it comes from
    # the client.
    def parse!(str)
      scanner = StringScanner.new(str)
      begin
        while (!scanner.eos?)
          start_pos = scanner.pos
          send(:"parse_#{@state}", scanner)
          if (scanner.pos == start_pos)
            # if we didn't move forward, we've run out of useful string so throw it back.
            return str
          end
        end
      ensure
        # clear out whatever we managed to scan.
        str[0, scanner.pos] = ""
      end
    end
    
    # Normalizes a header name to be UPPERCASE_WITH_UNDERSCORES
    def normalize_header(str)
      str.upcase.gsub('-', '_')
    end
    private :normalize_header
    
    # Given a basic rack environment, will properly fill it in
    # with the information gleaned from the parsed request. Note that
    # this only fills the subset that can be determined by the parser
    # library. Namely, the only rack. variable set is rack.input. You should also
    # have defaults in place for SERVER_NAME and SERVER_PORT, as they
    # are required.
    def fill_rack_env(env = {})
      env["rack.input"] = @body || StringIO.new
      env["REQUEST_METHOD"] = @method
      env["SCRIPT_NAME"] = ""
      env["REQUEST_URI"] = @path
      env["PATH_INFO"], query = @path.split("?", 2)
      env["QUERY_STRING"] = query || ""
      if (@headers["HOST"] && !env["SERVER_NAME"])
        env["SERVER_NAME"], port = @headers["HOST"].split(":", 2)
        env["SERVER_PORT"] = port if port
      end
      @headers.each do |key, val|
        if (key == 'CONTENT_LENGTH' || key == 'CONTENT_TYPE')
          env[key] = val
        else
          env["HTTP_#{key}"] = val
        end
      end
      return env
    end
    
    # Returns true if the request is completely done.
    def done?
      @state == :done
    end
    
    # Returns true if the request has parsed the request-line (GET / HTTP/1.1) 
    def done_request_line?
      [:headers, :body_identity, :body_chunked, :body_chunked_tail, :done].include?(@state)
    end
    # Returns true if all the headers from the request have been consumed.
    def done_headers?
      [:body_identity, :body_chunked, :body_chunked_tail, :done].include?(@state)
    end
    # Returns true if the request's body has been consumed (really the same as done?)
    def done_body?
      done?
    end
  end
end