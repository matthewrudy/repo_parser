# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'repo_parser/version'

Gem::Specification.new do |spec|
  spec.name          = 'repo_parser'
  spec.version       = RepoParser::VERSION
  spec.authors       = ['Matthew Rudy Jacobs']
  spec.email         = ['matthewrudyjacobs@gmail.com']
  spec.summary       = 'RepoParser is a code example'
  spec.homepage      = 'https://github.com/matthewrudy/repo_parser'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty', '~> 0.13.3'

  spec.add_development_dependency 'bundler', '>= 1.6.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'rubocop', '~> 0.30.0'
  spec.add_development_dependency 'rubocop-rspec'
end
