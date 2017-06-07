class Vendor < ActiveRecord::Base
  attr_accessible :title
  has_many :prices
end
