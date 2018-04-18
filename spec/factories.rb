FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "helloworld"
    password_confirmation "helloworld"
    remember_created_at Time.now
  end

  factory :picture do
    file { Faker::Name.name }
    user_id { Faker::Hipster.sentence }
  end
end
