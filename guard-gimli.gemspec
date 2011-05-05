# encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require 'guard/gimli/version'

Gem::Specification.new do |s|
  s.name        = "guard-gimli"
  s.version     = Guard::GimliVersion::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Fredrik Wallgren']
  s.email       = ['fredrik.wallgren@gmail.com']
  s.homepage    = 'https://github.com/walle/guard-gimli'
  s.summary     = 'Guard gem for gimli'
  s.description = "Guard::Gimli automatically converts your markup files when they are modified."

  s.rubyforge_project = s.name

  s.add_dependency 'guard'
  s.add_dependency 'gimli'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rr'

  s.files        = Dir.glob('{lib}/**/*') + %w[LICENSE README.textile]
  s.require_path = 'lib'
end

