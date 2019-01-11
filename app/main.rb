require 'csv'
require 'active_record'
require_relative 'classifier'
Dir[File.join(__dir__, 'models', '*.rb')].each { |file| require file }

module Main
  DEFAULT_TRANSACTIONS_FILE = __dir__ + '/../spec/fixtures/transactions.csv'.freeze

  class << self
    def load!(transactions: nil)
      connect_to_db

      transactions_file = transactions || DEFAULT_TRANSACTIONS_FILE

      classifier = Classifier.new

      CSV.foreach(transactions_file) do |row|
        merchant = classifier.classify(row[0])

        puts "Matched merchant #{merchant.id} (#{merchant.name}) to description: '#{row[0]}'"
      end
    end

    private

    def connect_to_db
      config_file = File.join(__dir__, '..', 'db', 'config.yml')
      db_configuration = YAML.load(File.open(config_file))

      ActiveRecord::Base.establish_connection(db_configuration['development'])
    end
  end
end

transactions = ARGV[0] if ARGV.any?
Main.load!(transactions: transactions)
