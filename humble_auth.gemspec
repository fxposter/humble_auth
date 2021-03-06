$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "humble_auth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "humble_auth"
  s.version     = HumbleAuth::VERSION
  s.authors     = ["Pavel Forkert (fxposter)"]
  s.email       = ["fxposter@g,ail.com"]
  s.homepage    = "https://github.com/fxposter/humble_auth"
  s.summary     = "The simplest authentication solution for Rails 3"
  s.description = "HTTP Basic authentication solution for Rails 3"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "railties", ">= 3.0", "< 5.0"
  s.add_development_dependency "test-unit"
  s.add_development_dependency "appraisal"
end
