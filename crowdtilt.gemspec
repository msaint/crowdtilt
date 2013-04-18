Gem::Specification.new do |s|
  s.name        = 'crowdtilt'
  s.version     = '0.0.1'
  s.date        = '2013-04-17'
  s.summary     = "Crowdtilt Ruby Client"
  s.description = "A lightweight ruby wrapper for the Crowdtilt API"
  s.authors     = ["Marc St Raymond"]
  s.email       = 'marc@crowditlt.com'
  s.files       = ["lib/crowdtilt.rb"]
  s.homepage    = 'https://www.crowdtilt.com/learn/developers'
  
  s.add_development_dependency 'bundler', '~> 1.0'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 1.3.0'

  
  s.add_dependency 'faraday', ['~> 0.8', '< 0.10']
  
end