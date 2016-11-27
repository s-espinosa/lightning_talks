FactoryGirl.define do
  factory :user do
    provider "github"
    sequence :uid do |n|
      "12345#{n}"
    end
    name "First Last"
    email "first@last.com"
    nickname "nick"
    github "https://github.com/nick"

    factory :admin do
      role 1
    end
  end

  factory :project do
    group_members "Sharon Jones"
    sequence :name do |n|
      "Witty Name #{n}"
    end
    project_type "BE Mod 3"
    final_confirmation true
  end
end
