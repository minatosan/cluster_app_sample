require 'faker'
FactoryBot.define do
  factory :user do
    email {Faker::Internet.email}
    password {"password"}
    last_name {"tarou"}
    first_name {"yamada"}
    last_name_kana {"たろう"}
    first_name_kana {"やまだ"}
    cell_phone {9011112222}
    created_at {Time.now}
    updated_at {Time.now}
    confirmed_at { Date.today }
  end
end
