# -*- encoding: utf-8 -*-
# stub: http_parser 0.1.3 ruby lib

Gem::Specification.new do |s|
  s.name = "http_parser".freeze
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Graham Batty".freeze]
  s.date = "2010-03-17"
  s.description = "This gem provides a (hopefully) high quality http parser library that can\n    build request information iteratively as data comes over the line without\n    requiring the caller to maintain the entire body of the request as a single\n    string in memory.".freeze
  s.email = "graham@stormbrew.ca".freeze
  s.extra_rdoc_files = ["LICENSE".freeze, "README.rdoc".freeze]
  s.files = ["LICENSE".freeze, "README.rdoc".freeze]
  s.homepage = "http://github.com/stormbrew/http_parser".freeze
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.rubygems_version = "3.0.3.1".freeze
  s.summary = "HTTP Parser Library".freeze

  s.installed_by_version = "3.0.3.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>.freeze, [">= 1.2.9"])
    else
      s.add_dependency(%q<rspec>.freeze, [">= 1.2.9"])
    end
  else
    s.add_dependency(%q<rspec>.freeze, [">= 1.2.9"])
  end
end
