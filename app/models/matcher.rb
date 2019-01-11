require 'active_record'

class Matcher < ActiveRecord::Base
  belongs_to :merchant

  def match(description)
    /#{regex}/.match?(description)
  end
end
