FactoryGirl.define do
  factory :article do
    sequence(:title) { |n| "Article No. #{n}"}
    sequence(:body) { |n| "Lorem Ipsum #{n}."}

    factory :past_article do
      valid_from { 1.year.ago }
      valid_to { 1.hour.ago }
    end
  end
end