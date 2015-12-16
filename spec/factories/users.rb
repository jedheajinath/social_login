FactoryGirl.define do
  factory :user do
    name "Test User"
    email "test@example.com"
    password "please123"
    provider nil
  end

  factory :facebook_user, class: User do
    name "Test User"
    email "test@example.com"
    password "please123"
    provider "facebook"
  end

  factory :twitter_user, class: User do
    name "Test User"
    email "test@example.com"
    password "please123"
    provider "twitter"
  end

  factory :instagram_user, class: User do
    name "Test User"
    email "test@example.com"
    password "please123"
    provider "instagram"
  end

  factory :google_user, class: User do
    name "Test User"
    email "test@example.com"
    password "please123"
    provider "google_oauth2"
  end
end