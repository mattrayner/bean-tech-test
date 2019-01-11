FactoryBot.define do
  factory :matcher do
    merchant

    regex { 'Bean$' }
  end
end
