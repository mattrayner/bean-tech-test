require 'active_record'

class Merchant < ActiveRecord::Base
  include ActiveModel::Validations

  belongs_to :parent, class_name: 'Merchant'

  has_many :matchers
  has_many :transactions
  has_many :children, foreign_key: 'parent_id', class_name: 'Merchant'

  validates :name, presence: true
end
