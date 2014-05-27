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
      it { should include current_article }
      it { should_not include past_article }
    end
    
    describe ".now" do
      subject(:now_scope) { class_with_temporal_scopes.now }
      it { should be_kind_of ActiveRecord::Relation }
      it { should include current_article }
      it { should_not include past_article }
    end
    
    describe ".past" do
      subject(:past_scope) { class_with_temporal_scopes.past }
      it { should be_kind_of ActiveRecord::Relation }
      it { should include past_article }
      it { should_not include current_article }
    end
    
    describe ".with_past" do
      subject(:with_past_scope) { class_with_temporal_scopes.with_past }
      it { should be_kind_of ActiveRecord::Relation }
      it { should include current_article }
      it { should include past_article }
    end
    
    describe "#valid_from"
    describe "#valid_to"
    
    describe "#archive" do
      describe "when not archived (=current)" do
        subject(:archive_current_article) { current_article.archive }
        it "makes the object fall under the :past scope" do
          expect(class_with_temporal_scopes.past).not_to include current_article
          archive_current_article
          expect(class_with_temporal_scopes.past).to include current_article
        end
        it "sets the :valid_to attribute to the current time" do
          Timecop.freeze do
            expect(current_article.valid_to).to be_nil
            archive_current_article
            expect(current_article.valid_to).to eq(Time.zone.now)
          end
        end
        it "returns the archived object" do
          expect(archive_current_article).to eq(current_article)
        end
        describe "with :at parameter" do
          subject(:archive_current_article_1_hour_ago) { current_article.archive at: 1.hour.ago }
          it "sets the :valid_to attribute to the given time" do
            Timecop.freeze do
              expect(current_article.valid_to).to be_nil
              archive_current_article_1_hour_ago
              expect(current_article.valid_to).to eq(1.hour.ago)
            end
          end
        end
      end
      describe "when already archived (=past)" do
        subject(:archive_past_article) { past_article.archive }
        it "keeps the :valid_to attribute as it was" do
          valid_to_as_it_was_before = past_article.valid_to
          archive_past_article
          expect(past_article.reload.valid_to.to_s).to eq(valid_to_as_it_was_before.to_s)
        end
      end
    end
    
  end
  
end