FactoryBot.define do
  factory :profile do
    nickname {"サンプル"}
    text {"テストユーザーです"}
    association :user
    avatar{ Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpeg'))}
    #created_at {Time.now}
  end
end
