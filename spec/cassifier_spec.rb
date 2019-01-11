require 'csv'

RSpec.describe Classifier do
  subject(:classifier) { described_class.new }

  describe '.classify' do
    before(:each) do
      Kernel.silence_warnings { load(__dir__ + '/../db/seeds.rb') }
    end

    context 'when no match is found' do
      let(:description) { 'This is an test description' }

      it "creates an 'unknown' merchant and attaches the transaction to it" do
        merchant = classifier.classify(description)
        expect(merchant.name).to eq('unknown')
        expect(merchant.transactions.size).to eq(1)

        transaction = merchant.transactions.first
        expect(transaction.description).to eq(description)
        expect(transaction.matcher).to eq(nil)
      end
    end

    context 'when a match is found' do
      CSV.foreach(__dir__ + '/fixtures/transactions.csv') do |row|
        it "matches '#{row[0]}' to '#{row[1].strip}' as expected" do
          expect(classifier.classify(row[0]).name).to eq(row[1].strip)
        end
      end

      it 'creates a new transaction and links it correctly to a merchant and matcher' do
        merchant = create(:merchant, name: 'Test merchant')
        matcher = create(:matcher, regex: 'test$', merchant: merchant)

        description = 'This is a test'

        classifier.classify(description)

        transaction = Transaction.last
        expect(transaction.description).to eq(description)
        expect(transaction.matcher).to eq(matcher)
        expect(transaction.merchant).to eq(merchant)
      end

      context 'when a description matches multiple merchants' do
        it 'returns the first one from the database' do
          expect(classifier.classify("netflix amazon uber sainsbury's").name).to eq('Sainsburys')
        end
      end
    end
  end
end
