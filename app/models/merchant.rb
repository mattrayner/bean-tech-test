require 'active_record'

class Merchant < ActiveRecord::Base
  has_many :matchers
  has_many :children, foreign_key: 'merchant_id', class_name: 'Merchant'

  def match(description); end
end
