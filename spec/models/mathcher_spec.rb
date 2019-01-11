RSpec.describe Matcher do
  it 'has a valid factory' do
    expect(create(:matcher).valid?).to eq(true)
  end

  describe 'properties' do
    it 'enforces a non-null regex attribute' do
      expect { Matcher.new.save }.to raise_error(ActiveRecord::NotNullViolation, 'SQLite3::ConstraintException: NOT NULL constraint failed: matchers.regex: INSERT INTO "matchers" ("created_at", "updated_at") VALUES (?, ?)')

      matcher = build(:matcher, regex: '/Bean$/')
      expect(matcher.save).to eq(true)
    end
  end

  describe '#match' do
    let(:matcher) { create(:matcher, regex: 'test$') }

    context 'with a matching string' do
      it 'returns true' do
        expect(matcher.match('This is a test')).to eq(true)
      end
    end

    context 'without a matching string' do
      it 'returns false' do
        expect(matcher.match('This is a test foo')).to eq(false)
      end
    end
  end
end
