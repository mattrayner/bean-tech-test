require_relative 'models/matcher'
require_relative 'models/transaction'

class Classifier
  attr_reader :matchers

  def initialize
    @matchers = Matcher.joins(:merchant).where(merchants: { parent_id: nil })
  end

  def classify(description)
    matches = find_matches(@matchers, description)

    # Try and find a more-specific child match
    if matches.any?
      child_matchers = matches
                       .map { |matcher| matcher.merchant.children }
                       .flatten
                       .map(&:matchers)
                       .flatten

      child_matches = find_matches(child_matchers, description)
      matches = child_matches if child_matches.any?
    end
    matcher = matches.first
    merchant = matcher.nil? ? Merchant.create(name: 'unknown') : matcher.merchant

    Transaction.create(description: description, merchant: merchant, matcher: matcher)

    merchant
  end

  private

  def find_matches(matcher_array, description)
    matcher_array.select { |matcher| matcher.match?(description) }
  end
end
