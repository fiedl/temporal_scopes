require 'spec_helper'

RSpec.describe TemporalScopes::HasTemporalScopes do
  
  it "adds the #has_temporal_scopes method to ActiveRecord::Base" do
    expect(ActiveRecord::Base).to respond_to :has_temporal_scopes
  end
  
end