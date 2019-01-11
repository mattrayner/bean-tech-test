RSpec.describe Merchant do
  it 'has valid factories' do
    expect(create(:merchant).valid?).to eq(true)
    expect(create(:merchant_with_children).valid?).to eq(true)
  end

  describe 'properties' do
    it 'enforces a non-null name attribute' do
      expect { described_class.new.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Name can't be blank")

      merchant = build(:merchant, name: 'Bean')
      expect(merchant.save!).to eq(true)
    end
  end
end
