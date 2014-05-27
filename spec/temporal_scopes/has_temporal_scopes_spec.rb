require 'spec_helper'

RSpec.describe TemporalScopes::HasTemporalScopes do
  
  it "adds the #has_temporal_scopes method to ActiveRecord::Base" do
    expect(ActiveRecord::Base).to respond_to :has_temporal_scopes
  end
  
  describe "with a class having temporal scopes" do
    # 
    # Here, we use the Article class defined in the dummy app
    # as an example.
    # 
    # class Article < ActiveRecord::Base
    #   has_temporal_scopes
    #   
    # end
    #
    subject(:class_with_temporal_scopes) { Article }
    
    let(:current_article) { create(:article) }
    let(:past_article) { create(:past_article) }
    
    describe ".all (default scope)" do
      subject(:default_scope) { class_with_temporal_scopes.all }
      it { should be_kind_of ActiveRecord::Relation }
      it "returns current objects" do
        expect(default_scope).to include current_article
      end
      it "returns no past objects" do
        expect(default_scope).not_to include past_article
      end
    end
    
    describe ".now" do
      subject(:now_scope) { class_with_temporal_scopes.now }
      it { should be_kind_of ActiveRecord::Relation }
      it "returns current objects" do
        expect(now_scope).to include current_article
      end
      it "returns no past objects" do
        expect(now_scope).not_to include past_article
      end
    end
    
    describe ".past" do
      subject(:past_scope) { class_with_temporal_scopes.past }
      it { should be_kind_of ActiveRecord::Relation }
      it "returns past objects" do
        p past_scope.to_sql
        expect(past_scope).to include past_article
      end
      it "returns no current objects" do
        expect(past_scope).not_to include current_article
      end
    end
    
    describe ".with_past"
    describe "#valid_from"
    describe "#valid_to"
    describe "#archive"
    
  end
  
end