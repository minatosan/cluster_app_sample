FactoryBot.define do
  factory :article_image do
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpeg'))}
  end
end
