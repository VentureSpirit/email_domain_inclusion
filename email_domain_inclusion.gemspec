# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'email_domain_inclusion/version'

Gem::Specification.new do |spec|
  spec.name          = "email_domain_inclusion"
  spec.version       = EmailDomainInclusion::VERSION
  spec.authors       = ["Andrew Fecheyr"]
  spec.email         = ["andrew@bedesign.be"]
  spec.summary       = %q{ActiveModel email domain in whitelist validator}
  spec.description   = %q{ActiveModel validator that checks if a given email has a whitelisted domain}
  spec.homepage      = "https://github.com/andruby/email_domain_inclusion"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
