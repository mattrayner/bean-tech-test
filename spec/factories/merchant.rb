FactoryBot.define do
  factory :merchant do
    name { 'Bean' }

    after(:create) do |merchant|
      create_list(:matcher, 1, merchant: merchant)
    end

    factory :merchant_with_children do
      after(:create) do |merchant|
        matchers = [
          create(:matcher, regex: '/^Test/'),
          create(:matcher, regex: '/- test$/')
        ]
        merchant.children << create(:merchant, name: 'Test', matchers: matchers)
      end
    end
  end
end
