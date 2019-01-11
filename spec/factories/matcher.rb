FactoryBot.define do
  factory :matcher do
    regex { 'Bean$' }

    merchant
  end
end
