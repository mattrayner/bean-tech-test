RSpec.describe Transaction do
  it 'has a valid factory' do
    expect(create(:transaction).valid?).to eq(true)
  end

  describe 'properties' do
    it 'enforces a non-null description attribute' do
      matcher = Transaction.new
      matcher.merchant = create(:merchant)
      expect{ matcher.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Description can't be blank")
    end

    it 'enforces presence of merchant' do
      matcher = Transaction.new
      matcher.description = 'test'
      expect{ matcher.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Merchant can't be blank")
    end
  end
end
