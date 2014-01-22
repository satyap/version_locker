# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version_locker/version'

Gem::Specification.new do |spec|
  spec.name          = "version_locker"
  spec.version       = VersionLocker::VERSION
  spec.authors       = ["Scott Holden"]
  spec.email         = ["scott@sshconnection.com"]
  spec.summary       = %q{}
  spec.description   = %q{Specify versions in Gemfile based on what is currently loaded}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
