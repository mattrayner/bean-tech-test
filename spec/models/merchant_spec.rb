RSpec.describe Merchant do
  it 'has valid factories' do
    expect(create(:merchant).valid?).to eq(true)
    expect(create(:merchant_with_children).valid?).to eq(true)
  end

  describe 'properties' do
    it 'enforces a non-null name attribute' do
      expect { Merchant.new.save }.to raise_error(ActiveRecord::NotNullViolation, 'SQLite3::ConstraintException: NOT NULL constraint failed: merchants.name: INSERT INTO "merchants" ("created_at", "updated_at") VALUES (?, ?)')

      merchant = build(:merchant, name: 'Bean')
      expect(merchant.save).to eq(true)
    end
  end

  describe '#match' do
    context 'with a matching string' do
      context 'with a single matcher object' do
        subject(:merchant) { create(:merchant) }

        it 'returns the expected matcher' do
          pending
        end
      end

      context 'with multiple matcher objects' do
        it 'returns the expected matcher' do
          pending
        end
      end

      context 'with a matching child' do
        it 'returns the expected matcher' do
          pending
        end
      end
    end

    context 'without a matching string' do
      it 'returns nil' do
        pending
      end
    end
  end
end
