FactoryGirl.define do
  factory :user do
    name "User User"
    first_name "User"
    email "user@example.com"
    provider "Facebook"
  end

  factory :upload do
    url "www.example.com"
    meaning "manzana"
    user

    factory :upload_without_meaning do
      meaning "no meaning"
    end
  end
end
