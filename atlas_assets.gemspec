# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'atlas_assets/version'

Gem::Specification.new do |gem|
  gem.name          = "atlas_assets"
  gem.version       = Atlas::Assets::VERSION
  gem.authors       = ["O'Reilly Tools Team"]
  gem.email         = ["toolsreq@oreilly.com"]
  gem.description   = %q{Public repository with assets for the Atlas platform}
  gem.summary       = %q{Public repository with assets for the Atlas platform}

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "handlebars_assets", "0.23.1"
end
