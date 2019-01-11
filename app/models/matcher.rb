require 'active_record'

class Matcher < ActiveRecord::Base
  include ActiveModel::Validations

  belongs_to :merchant
  has_many :transactions

  validates :regex, :merchant, presence: true

  def match?(description)
    /#{regex}/.match?(description)
  end
end
