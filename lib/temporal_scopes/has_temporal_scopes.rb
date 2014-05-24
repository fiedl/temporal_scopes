require 'active_record'

module TemporalScopes
  module HasTemporalScopes
    
    def has_temporal_scopes
    end
    
  end
end

ActiveRecord::Base.send(:extend, TemporalScopes::HasTemporalScopes)