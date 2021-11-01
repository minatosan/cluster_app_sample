FactoryBot.define do
  factory :article do
    title {"sample"}
    introduction {"テスト記事です"}
    text {"テスト記事の本文です"}
    created_at {Time.now}
    updated_at {Time.now}

  end
end
