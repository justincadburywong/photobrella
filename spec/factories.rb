FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "helloworld" }
    password_confirmation { "helloworld" }
    remember_created_at { Time.now }
  end

  factory :picture do
    file_data { Faker::File.file_name('foo\bar', 'baz', 'jpg', '\ ') }
    user_id { Faker::Number.number(1) }
    tags { Faker::Types.array }
  end
end
