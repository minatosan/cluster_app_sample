FactoryBot.define do
  factory :comment do
    text {"test"}
    user_id {1}
    article_id {1}
  end
end
