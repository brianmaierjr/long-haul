module Http
  require 'http/native_parser'
  begin
    require 'http/fast_parser'
    Parser = FastParser
  rescue LoadError => e
    Parser = NativeParser
  end
  
  # An exception class for HTTP parser errors. Includes
  # an HTTP Error Code number that corresponds to the
  # difficulty parsing (ie. 414 for Request-URI Too Long)
  class ParserError < RuntimeError
    # The error code that corresponds to the parsing error.
    attr_reader :code
    # Headers that should be sent back with the error reply as a hash.
    attr_reader :headers
    
    def initialize(string = "Bad Request", code = 400, headers = {})
      super(string)
      @code = code
      @headers = headers
    end
    
    class BadRequest < ParserError; end
    class RequestTimeout < ParserError; def initialize(); super("Request Timeout", 408); end; end
    class LengthRequired < ParserError; def initialize(); super("Length Required", 411); end; end
    class RequestEntityTooLarge < ParserError; def initialize(); super("Request Entity Too Large", 413); end; end
    class RequestURITooLong < ParserError; def initialize(); super("Request-URI Too Long", 414); end; end
    class NotImplemented < ParserError; def initialize(); super("Method Not Implemented", 501); end; end # Send Allow header
  end
end