# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "project-fifo-ruby"
  spec.version       = '0.3.0'
  spec.authors       = [ "Brian Akins" ]
  spec.email         = [ "brian@akins.org" ]
  spec.description   = %q{A simple incomplete project-fifo client API}
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/bakins/project-fifo-ruby"
  spec.license       = "Apache 2.0"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 1.9.1"
  spec.add_dependency("rest-client", "~> 1.6")
  spec.add_dependency("hashie", "~> 2.0")
  spec.add_dependency("json")
  spec.add_dependency("hash_validator")
end
