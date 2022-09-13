require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'http/parser'

test_parsers = [Http::NativeParser]
test_parsers << Http::FastParser if Http.const_defined? :FastParser

describe Http::Parser do
  it "should be a reference to Http::NativeParser, or if present Http::FastParser" do
    Http.const_defined?(:Parser).should be_true
    if (Http.const_defined?(:FastParser))
      Http::Parser.should == Http::FastParser
    else
      Http::Parser.should == Http::NativeParser
    end
  end
end

test_parsers.each do |parser|
  describe parser do
    it "should be able to parse a simple GET request" do
      p = parser.new
    	p.parse("GET / HTTP/1.1\r\n")
    	p.parse("Host: blah.com\r\n")
    	p.parse("Cookie: blorp=blah\r\n")
    	p.parse("\r\n")

      p.done?.should be_true
    	p.method.should == "GET"
    	p.version.should == [1,1]
    	p.path.should == "/"
    	p.headers["HOST"].should == "blah.com"
    	p.headers["COOKIE"].should == "blorp=blah"
  	end
  	
    it "should raise an error on a malformed request line" do
      p = parser.new
      proc {
        p.parse("GET / HTTx/balh.blorp\r\n")
      }.should raise_error(Http::ParserError::BadRequest)
      proc {
        p.parse("GET HTTP/1.1\r\n")
      }.should raise_error(Http::ParserError::BadRequest)
    end
    
    it "should raise an error on a malformed header line" do
      p = parser.new
      p.parse("GET / HTTP/1.1\r\n")
      proc {
        p.parse("Stuff\r\n")
      }.should raise_error(Http::ParserError::BadRequest)
    end
    
  	it "should be able to parse a request with a body defined by a Content-Length (ie. PUT)" do
  	  p = parser.new
    	p.parse("PUT / HTTP/1.1\r\n")
    	p.parse("Host: blah.com\r\n")
    	p.parse("Content-Type: text/text\r\n")
    	p.parse("Content-Length: 5\r\n")
    	p.parse("\r\n")
    	p.parse("stuff")

    	p.body.read.should == "stuff"
  	end
  	
  	describe "fill_rack_env" do
  	  it "should fill in a simple request correctly" do
  	    p = parser.new
  	    p.parse("GET /blah HTTP/1.1\r\nHost: blorp\r\n\r\n")
  	    p.done?.should be_true
  	    env = p.fill_rack_env
  	    env["rack.input"].should be_kind_of(StringIO)
  	    env["REQUEST_METHOD"].should == "GET"
  	    env["SCRIPT_NAME"].should == ""
  	    env["REQUEST_URI"].should == "/blah"
  	    env["PATH_INFO"].should == "/blah"
  	    env["QUERY_STRING"].should == ""
  	    env["SERVER_NAME"].should == "blorp"
  	    env["SERVER_PORT"].should be_nil
  	    env["HTTP_HOST"].should == "blorp"
	    end
	    
      it "should give Content-Type and Content-Length as CONTENT_* rather than HTTP_CONTENT_*" do
        p = parser.new
        p.parse("POST /blah HTTP/1.1\r\nContent-Type: text/text\r\nContent-Length: 4\r\n\r\ntest")
        p.done?.should be_true
        env = p.fill_rack_env
        env["CONTENT_LENGTH"].should == "4"
        env["CONTENT_TYPE"].should == "text/text"
        env["HTTP_CONTENT_LENGTH"].should be_nil
        env["HTTP_CONTENT_TYPE"].should be_nil
      end

	    it "should split the query string from the request uri" do
	      p = parser.new
	      p.parse("GET /blah?blorp HTTP/1.1\r\nHost: blorp\r\n\r\n")
	      p.done?.should be_true
	      env = p.fill_rack_env
	      env["REQUEST_URI"].should == "/blah?blorp"
	      env["PATH_INFO"].should == "/blah"
	      env["QUERY_STRING"].should == "blorp"
      end
      it "should split the query string from the path only once" do
        p = parser.new
        p.parse("GET /blah?blorp?bloop HTTP/1.1\r\nHost:blorp\r\n\r\n")
        p.done?.should be_true
        env = p.fill_rack_env
        env["REQUEST_URI"].should == "/blah?blorp?bloop"
        env["PATH_INFO"].should == "/blah"
        env["QUERY_STRING"].should == "blorp?bloop"
      end
      
      it "should split the host from the port when doing SERVER_NAME/SERVER_PORT" do
        p = parser.new
        p.parse("GET /blah HTTP/1.1\r\nHost: blorp.com:1234\r\n\r\n")
        p.done?.should be_true
        env = p.fill_rack_env
        env["SERVER_NAME"].should == "blorp.com"
        env["SERVER_PORT"].should == "1234"
      end
      
      it "should not fill in SERVER_NAME and SERVER_PORT if SERVER_NAME is already set" do
        p = parser.new
        p.parse("GET /blah HTTP/1.1\r\nHost: blah.com:324\r\n\r\n")
        p.done?.should be_true
        env = p.fill_rack_env({"SERVER_NAME"=>"woop.com"})
        env["SERVER_NAME"].should == "woop.com"
      end
    end

  	it "should be able to parse two simple requests from the same string" do
  	  req = <<REQ
GET /first HTTP/1.1\r
Host: blah.com\r
\r
GET /second HTTP/1.1\r
Host: blorp.com\r
\r
REQ
      p = parser.new
      p.parse!(req)
      p.done?.should be_true
      p.method.should == "GET"
      p.version.should == [1,1]
      p.path.should == "/first"
      p.headers["HOST"].should == "blah.com"
      p.has_body?.should be_false
      
      p = parser.new
      p.parse!(req)
      p.done?.should be_true
      p.method.should == "GET"
      p.version.should == [1,1]
      p.path.should == "/second"
      p.headers["HOST"].should == "blorp.com"
      p.has_body?.should be_false
    end

  	it "should be able to parse two requests with length-prefixed entities from the same string" do
  	  req = <<REQ
POST /first HTTP/1.1\r
Host: blah.com\r
Content-Length: 5\r
\r
test
POST /second HTTP/1.1\r
Host: blorp.com\r
Content-Length: 5\r
\r
haha
REQ
      p = parser.new
      p.parse!(req)
      p.done?.should be_true
      p.method.should == "POST"
      p.version.should == [1,1]
      p.path.should == "/first"
      p.headers["HOST"].should == "blah.com"
      p.body.read.should == "test\n"

      p = parser.new
      p.parse!(req)
      p.done?.should be_true
      p.method.should == "POST"
      p.version.should == [1,1]
      p.path.should == "/second"
      p.headers["HOST"].should == "blorp.com"
      p.body.read.should == "haha\n"
    end
  	
  	it "should be able to parse two requests with chunked entities from the same string" do
  	  req = <<REQ
POST /first HTTP/1.1\r
Host: blah.com\r
Transfer-Encoding: chunked\r
\r
5\r
test
\r
0\r
\r
POST /second HTTP/1.1\r
Host: blorp.com\r
Transfer-Encoding: chunked\r
\r
5\r
haha
\r
0\r
\r
REQ
      p = parser.new
      p.parse!(req)
      p.done?.should be_true
      p.method.should == "POST"
      p.version.should == [1,1]
      p.path.should == "/first"
      p.headers["HOST"].should == "blah.com"
      p.body.read.should == "test\n"

      p = parser.new
      p.parse!(req)
      p.done?.should be_true
      p.method.should == "POST"
      p.version.should == [1,1]
      p.path.should == "/second"
      p.headers["HOST"].should == "blorp.com"
      p.body.read.should == "haha\n"
    end
    
  	it "should be able to parse a request with a body defined by Transfer-Encoding: chunked" do
  	  p = parser.new
  	  p.parse(<<REQ)
POST / HTTP/1.1\r
Host: blah.com\r
Transfer-Encoding: chunked\r
\r
A\r
stuffstuff\r
0\r
\r
REQ
      p.done?.should be_true
      p.body.read.should == "stuffstuff"
    end
    
    it "should deal with a properly set 0 length body on a PUT/POST request" do
      p = parser.new
      p.parse <<REQ
PUT / HTTP/1.1\r
Host: blah.com\r
Content-Length: 0\r
\r
REQ
      p.done?.should be_true
      p.body.read.should == ""
    end
    
    it "should handle a body that's too long to store in memory with a Content-Length by putting it out to a tempfile." do
      p = parser.new(:min_tempfile_size => 1024)
      p.parse <<REQ
POST / HTTP/1.1\r
Host: blah.com\r
Content-Length: 2048\r
\r
REQ
      p.parse("x"*2048)
      p.done?.should be_true
      p.body.should be_kind_of(Tempfile)
      p.body.read.should == "x" * 2048
    end
    
    it "should handle a body that's too long to store in memory with a Transfer-Encoding of chunked by putting it out to a tempfile" do
      p = parser.new(:min_tempfile_size => 1024)
      p.parse <<REQ
POST / HTTP/1.1\r
Host: blah.com\r
Transfer-Encoding: chunked\r
\r
REQ
      1.upto(200) do
        p.parse("A\r\n")
        p.parse("x"*10 + "\r\n")
      end
      p.parse("0\r\n\r\n")
      p.done?.should be_true
      p.body.should be_kind_of(Tempfile)
      p.body.read.should == "x" * 2000
    end
  	
  	it "Should be able to incrementally parse a request with arbitrarily placed string endings" do
  	  p = parser.new
    	s = "GET / HTT"
    	p.parse!(s)
    	s.should == "GET / HTT"
    	p.done_request_line?.should be_false
    	p.done_headers?.should be_false
    	p.done?.should be_false
    	
    	s << "P/1.1\r\nHost:"
    	p.parse!(s)
    	s.should == "Host:"
    	p.method.should == "GET"
    	p.path.should == "/"
    	p.version.should == [1,1]
    	p.done_request_line?.should be_true
    	p.done_headers?.should be_false
    	p.done?.should be_false
    	
    	s << " blah.com\r\n"
    	p.parse!(s)
    	s.should == ""
    	p.headers["HOST"].should == "blah.com"
    	p.done_headers?.should be_false
    	p.done?.should be_false
    	
    	s << "\r\n"
    	p.parse!(s)
    	s.should == ""
    	p.done_headers?.should be_true
    	p.done?.should be_true
  	end
  	
  	describe "RFC2616 sec 3.1 (HTTP Version)" do
  	  it "MUST accept arbitrary numbers for the version string" do
  	    p = parser.new
  	    p.parse("GET / HTTP/12.3445\r\n")
  	    
  	    p.done_request_line?.should be_true
  	    p.version.should == [12,3445]
	    end
    end
    
    describe "RFC2616 sec 4.1 (Message Type)" do
      it "SHOULD ignore leading whitespace lines before a request-line" do
        p = parser.new
        p.parse("\r\n")
        p.parse("GET / HTTP/1.1\r\n")
        
        p.done_request_line?.should be_true
      end
    end     
  	
  	describe "RFC2616 sec 4.2 (Message Headers)" do
    	it "MUST ignore leading spaces on header values" do
  	    p = parser.new
  	    p.parse("GET / HTTP/1.1\r\n")
  	    p.parse("Blah:    wat?\r\n")
  	    p.parse("\r\n")
	    
  	    p.done?.should be_true
  	    p.headers["BLAH"].should == "wat?"
      end
  	
    	it "MUST be able to handle a header that spans more then one line" do
    	  p = parser.new
    	  p.parse("GET / HTTP/1.1\r\n")
    	  p.parse("Blah: blorp\r\n")
    	  p.parse(" woop\r\n")
    	  p.parse("\r\n")
  	  
    	  p.done?.should be_true
    	  p.headers["BLAH"].should == "blorp woop"
  	  end

    	it "MUST ignore any amount of leading whitespace on multiline headers" do
    	  p = parser.new
    	  p.parse("GET / HTTP/1.1\r\n")
    	  p.parse("Blah: blorp\r\n")
    	  p.parse(" \t woop\r\n")
    	  p.parse("\r\n")
  	  
    	  p.done?.should be_true
    	  p.headers["BLAH"].should == "blorp woop"
  	  end
  	  
  	  it "MUST be able to merge multiple headers into one comma separated header with order preserved" do
  	    p = parser.new
  	    p.parse("GET / HTTP/1.1\r\n")
  	    p.parse("Blah: blorp\r\n")
  	    p.parse("Blah: woop\r\n")
  	    p.parse("Woop: bloop\r\n")
  	    p.parse("Woop: noop\r\n")
  	    p.parse("\r\n")
  	    
  	    p.done?.should be_true
  	    p.headers["BLAH"].should == "blorp,woop"
  	    p.headers["WOOP"].should == "bloop,noop"
	    end
	  end
	  
	  describe "RFC2616 sec 4.3 (Message Body)" do
      ["GET","DELETE","HEAD","TRACE","CONNECT"].each do |method|
  	    it "MUST NOT require a body on #{method} requests" do
  	      p = parser.new
  	      p.parse("#{method} / HTTP/1.1\r\n")
  	      p.parse("Host: blah.com\r\n")
  	      p.parse("\r\n")
  	      
  	      p.done?.should be_true
  	      p.body.should be_nil
	      end

  	    it "SHOULD accept (but ignore) a message body on #{method} requests" do
  	      p = parser.new
  	      req = <<REQ
#{method} / HTTP/1.1\r
Content-Length: 6\r
\r
stuff
REQ
          p.parse!(req)
          
          p.done?.should be_true
  	      p.headers["CONTENT_LENGTH"].should == "6"
  	      p.body.should be_nil
  	      
  	      req.should == ""
        end
      end
      
      ["POST","PUT"].each do |method|
        it "MUST accept a body on #{method} requests" do
          p = parser.new
          p.parse("#{method} / HTTP/1.1\r\n")
          p.parse("Content-Length: 5\r\n")
          p.parse("\r\n")
          p.parse("stuff")
          
          p.done?.should be_true
          p.body.should_not be_nil
          p.body.read.should == "stuff"
        end
        
        it "MUST require a body on #{method} requests" do
          p = parser.new
          proc {
            p.parse("#{method} / HTTP/1.1\r\n")
            p.parse("Host: blah.com\r\n")
            p.parse("\r\n")
          }.should raise_error(Http::ParserError::LengthRequired)
        end
      end
      
      it "SHOULD accept and allow a body on OPTIONS requests" do
        p = parser.new
        p.parse("OPTIONS / HTTP/1.1\r\n")
        p.parse("Content-Length: 5\r\n")
        p.parse("\r\n")
        p.parse("stuff")
        
        p.done?.should be_true
        p.body.should_not be_nil
        p.body.read.should == "stuff"
      end
      
      it "MUST accept an OPTIONS request with no body" do
        p = parser.new
        p.parse("OPTIONS / HTTP/1.1\r\n")
        p.parse("\r\n")
        
        p.done?.should be_true
        p.body.should be_nil
      end
      
      it "MUST choose chunked-encoding length over content-length header" do
        p = parser.new
        p.parse(<<REQ)
POST / HTTP/1.1\r
Content-Length: 5
Transfer-Encoding: chunked

A
stuffstuff
0

REQ
        p.done?.should be_true
        p.body.should_not be_nil
        p.body.read.should == "stuffstuff"
      end
    end
    
    describe "RFC2616 sec 5.1" do
      it "SHOULD raise a 501 error if given an unrecognized method" do
        p = parser.new
        proc {
          p.parse("OOGABOOGAH / HTTP/1.1\r\n")
        }.should raise_error(Http::ParserError::NotImplemented)
      end
    end      
  end
end