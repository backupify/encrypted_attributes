# -*- encoding: utf-8 -*-
require File.expand_path('../lib/encrypted_attributes/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jon Yurek"]
  gem.email         = ["jyurek@thoughtbot.com"]
  gem.description   = %q{Encrypts attributes transparently}
  gem.summary       = %q{Encrypts attributes transparently}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "encrypted_attributes"
  gem.require_paths = ["lib"]
  gem.version       = EncryptedAttributes::VERSION

  gem.add_development_dependency("rake")
  gem.add_development_dependency("ci_reporter")
  gem.add_development_dependency("simplecov")
  gem.add_development_dependency("simplecov-rcov")
end
