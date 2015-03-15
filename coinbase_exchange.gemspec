Gem::Specification.new do |s|
  s.name        = 'coinbase_exchange'
  s.version     = '0.0.3'
  s.date        = '2015-02-07'
  s.summary     = "Coinbase Exchange ruby client"
  s.description = "Coinbase Exchange ruby client"
  s.authors     = ["Dan Silver"]
  s.email       = 'dannysilver3@gmail.com'
  s.files       = Dir.glob('{bin,config,lib,test,doc}/**/*') + ['coinbase_exchange.gemspec']
  s.extra_rdoc_files = ['README.md']
  s.license     = 'MIT'
  s.homepage = 'https://github.com/dan-silver/coinbase_exchange'
  s.add_runtime_dependency 'unirest', '~> 1.1', '>= 1.1.2'
  s.add_runtime_dependency 'websocket-client-simple'
end
