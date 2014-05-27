require 'temporal_scopes'
require 'dummy_app/config/environment'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.include FactoryGirl::Syntax::Methods
  
  FactoryGirl.definition_file_paths = %w(spec/factories)
  FactoryGirl.find_definitions
end