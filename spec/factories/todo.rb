FactoryBot.define do
  factory :todo do
    sequence(:title) { |n| "Todo Item #{n}" }
  end
end
