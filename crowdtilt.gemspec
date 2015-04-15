Gem::Specification.new do |s|
  s.name        = 'crowdtilt'
  s.version     = '1.0.5'
  s.date        = '2015-04-14'
  s.summary     = "Tilt API Ruby Client"
  s.description = "A lightweight ruby wrapper for the Tilt API"
  s.authors     = ["Marc St Raymond", "Sam Wyman", "Henry Liu"]
  s.email       = 'support.api@tilt.com'
  s.files       = Dir.glob("lib/**/*")
  s.homepage    = 'https://github.com/Crowdtilt/crowdtilt-api-spec/'
  s.license     = 'MIT'

  s.add_development_dependency 'bundler', '~> 1.0'

  s.add_runtime_dependency 'faraday', '~> 0.9.1'
  s.add_runtime_dependency 'faraday_middleware', '~> 0.9.1'
  s.add_runtime_dependency 'activesupport', '~> 3.2.0'
  s.add_runtime_dependency 'json', '~> 1.8.0'
end
