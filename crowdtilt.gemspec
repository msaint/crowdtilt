Gem::Specification.new do |s|
  s.name        = 'crowdtilt'
  s.version     = '1.0.1'
  s.date        = '2013-08-16'
  s.summary     = "Crowdtilt Ruby Client"
  s.description = "A lightweight ruby wrapper for the Crowdtilt API"
  s.authors     = ["Marc St Raymond", "Sam Wyman"]
  s.email       = 'team@crowdhoster.com'
  s.files       = Dir.glob("lib/**/*")
  s.homepage    = 'https://www.crowdtilt.com/learn/developers'
  s.license = 'MIT'

  s.add_development_dependency 'bundler', '~> 1.0'

  s.add_runtime_dependency 'faraday', '~> 0.8.8'
  s.add_runtime_dependency 'faraday_middleware', '~> 0.9.0'
  s.add_runtime_dependency 'activesupport'
  s.add_runtime_dependency 'json'

end
