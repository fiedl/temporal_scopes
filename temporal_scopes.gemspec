$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "temporal_scopes/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "temporal_scopes"
  s.version     = TemporalScopes::VERSION
  s.authors     = ["Sebastian Fiedlschuster"]
  s.email       = ["sebastian@fiedlschuster.de"]
  s.homepage    = "https://github.com/fiedl/temporal_scopes"
  s.summary     = "Providing temporal scopes for an ActiveRecord model to allow queries by time. For example, `MyModel.now.where(...)`, `my_model.archive`, `MyModel.past.where(...)`."
  s.description = s.summary
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 4.1.1"

  s.add_development_dependency "sqlite3"
end
