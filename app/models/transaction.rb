require 'active_record'

class Transaction < ActiveRecord::Base
  include ActiveModel::Validations

  belongs_to :merchant
  belongs_to :matcher

  validates :description, :merchant, presence: true
end
