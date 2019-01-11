FactoryBot.define do
  factory :transaction do
    description { 'This is a transaction from Bean' }

    before(:create) do |transaction|
      transaction.merchant = create(:merchant)
      transaction.matcher = transaction.merchant.matchers.first
    end
  end
end
