class PaymentMethod < ActiveRecord::Base
  attr_accessible :title
  has_many :checkouts
end