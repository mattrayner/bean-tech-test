RSpec.describe Matcher do
  it 'has a valid factory' do
    expect(create(:matcher).valid?).to eq(true)
  end

  describe 'properties' do
    it 'enforces a non-null regex attribute' do
      matcher = Matcher.new
      matcher.merchant = create(:merchant)
      expect{ matcher.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Regex can't be blank")
    end

    it 'enforces presence of merchant' do
      matcher = Matcher.new
      matcher.regex = 'Bean$'
      expect{ matcher.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Merchant can't be blank")
    end
  end

  describe '#match?' do
    let(:matcher) { create(:matcher, regex: 'test$') }

    context 'with a matching string' do
      it 'returns true' do
        expect(matcher.match?('This is a test')).to eq(true)
      end
    end

    context 'without a matching string' do
      it 'returns false' do
        expect(matcher.match?('This is a test foo')).to eq(false)
      end
    end
  end
end
