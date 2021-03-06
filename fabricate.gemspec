# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fabricate/version'

Gem::Specification.new do |spec|
  spec.name          = "fabricate"
  spec.version       = Fabricate::VERSION
  spec.authors       = ["Nick Butler"]
  spec.email         = ["nick@codeindulgence.com"]

  spec.summary       = %q{Interface to the awesome [Faker](https://github.com/stympy/faker).}
  spec.homepage      = "https://github.com/codeindulgence/fabricate"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faker", "~> 1.6"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "pry-coolline", "~> 0.2.5"
end
