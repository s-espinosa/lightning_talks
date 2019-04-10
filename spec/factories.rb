FactoryGirl.define do
  factory :user, aliases: [:owner] do
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
    note "Note"
    lightning_talk
    owner
  end

  factory :lightning_talk do
    sequence :name do |n|
      "DemoName #{n}"
    end
    status 0
    final_date '2017/01/23'

    factory :lightning_talk_with_projects do
      after(:create) do |lightning_talk, evaluator|
        create_list(:project, 2, lightning_talk: lightning_talk)
      end
    end
  end

end
