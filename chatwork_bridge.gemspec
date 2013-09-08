# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chatwork_bridge/version'

Gem::Specification.new do |spec|
  spec.name          = "chatwork_bridge"
  spec.version       = ChatworkBridge::VERSION
  spec.authors       = ["Ryota Arai"]
  spec.email         = ["ryota.arai@gmail.com"]
  spec.description   = %q{Send ChatWork notifications via email, stdout and so on}
  spec.summary       = %q{Send ChatWork notifications via email, stdout and so on}
  spec.homepage      = "https://github.com/ryotarai/chatwork_bridge"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"

  spec.add_dependency "thor"
  spec.add_dependency "selenium-webdriver"
  spec.add_dependency "mail"
end
