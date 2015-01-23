# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'traject/solrj_writer/version'

Gem::Specification.new do |spec|
  spec.platform      = 'java'
  spec.name          = "traject-solrj_writer"
  spec.version       = Traject::SolrJWriter::VERSION
  spec.authors       = ["Bill Dueber"]
  spec.email         = ["bill@dueber.com"]
  spec.summary       = %q{Use Traject into index data into Solr using solrj under JRuby}
  spec.homepage      = "https://github.com/traject-project/traject-solrj_writer"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'traject',  "2.0.pre"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency 'simple_solr_client', '>=0.1.2'

end
