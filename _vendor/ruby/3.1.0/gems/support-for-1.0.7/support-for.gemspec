# -*- encoding: utf-8 -*-

Gem::Specification.new do |spec|
  spec.name        = 'support-for'

  spec.summary     = %q{Add conditional browser support to your Sass module}
  spec.description = %q{A module for Sass module developers to ease conditional browser support.}

  spec.homepage    = 'https://github.com/JohnAlbin/support-for'
  spec.rubyforge_project =

  spec.version     = '1.0.7'
  spec.date        = '2016-10-17'
  spec.licenses    = ['GPL-2.0']

  spec.authors     = ['John Albin Wilkins']
  spec.email       = 'virtually.johnalbin@gmail.com'

  spec.add_runtime_dependency('sass', '~> 3.3')

  spec.files       = `git ls-files`.split($/).select {|f| File.exist?(f) && f =~ %r{^(lib|sass)/} }
  spec.files       += %w(
    bower.json
    LICENSE.md
    package.json
    README.md
    support-for.gemspec
  )
end
