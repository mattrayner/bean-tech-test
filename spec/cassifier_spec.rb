require 'csv'

RSpec.describe Classifier do
  describe '.classify' do
    CSV.foreach(__dir__ + '/fixtures/transactions.csv') do |row|
      it "matches '#{row[0]}' to '#{row[1].strip}'" do
        expect(described_class.classify(row[0])).to eq(row[1].strip)
      end
    end
  end
end