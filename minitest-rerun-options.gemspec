# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "minitest-rerun-options"
  spec.version       = "0.0.2"
  spec.authors       = ["Ivan Tse"]
  spec.email         = ["ivan.tse1@gmail.com"]
  spec.summary       = %q{Outputs the command line options to rerun failing tests}
  spec.homepage      = "https://github.com/ivantsepp/minitest-rerun-options"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
