FactoryGirl.define do
  factory :user do
    name "User User"
    first_name "User"
    email "user@example.com"
    provider "Facebook"
  end

  factory :upload do
    sequence(:url)        { |n| "www.e#{n}xample.com" }
    sequence(:meaning)    { |n| "manzana#{n}" }
    sequence(:meaning_en) { |n| "apple#{n}" }
    user

    factory :upload_without_meaning do
      meaning "no meaning"
    end
  end
end
