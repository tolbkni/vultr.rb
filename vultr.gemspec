# Run `rake vultr.gemspec` to update the gemspec.

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vultr/version'

Gem::Specification.new do |s|
  s.name          = 'vultr'
  s.version       = Vultr::VERSION::STRING
  s.authors       = ['Gao Jiangmiao']
  s.email         = ['tolbkni@gmail.com']
  s.summary       = %q{Ruby bindings for VULTR API.}
  s.description   = %q{Ruby bindings for VULTR API. VULTR APIs can be found here: https://www.vultr.com/api/}
  s.homepage      = 'https://github.com/tolbkni/vultr.rb'
  s.license       = 'MIT'

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 1.9'

  s.add_dependency 'faraday', '~> 1.7'
  #s.add_dependency 'faraday_middleware', '~> 1.1'
end
