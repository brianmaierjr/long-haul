require File.expand_path(File.dirname(__FILE__) + '/bench_helper')

require 'http/parser'

request_body = <<REQ
GET /blakjsdfkas HTTP/1.1\r
Host: blooperblorp\r
Cookie: blah=woop\r
\r
REQ

#File.read(File.expand_path(File.dirname(__FILE__) + '/sample_request.http'))

Benchmark.bmbm(20) do |bm|
  bm.report("Http::NativeParser") do
    0.upto(100000) do
      Http::NativeParser.new.parse(request_body)
    end
  end
  begin
    require 'http11'
    bm.report("Mongrel::HttpParser") do
      0.upto(100000) do
        Mongrel::HttpParser.new.execute({}, request_body.dup, 0)
      end
    end
  rescue LoadError
    puts("Can't benchmark Mongrel::HttpParser as it couldn't be loaded.")
  end
end
    