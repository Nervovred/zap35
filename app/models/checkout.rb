class Checkout < ActiveRecord::Base
  attr_accessible :delivery_method_id, :email, :name, :payment_method_id, :phone, :status, :total, :user_id
  belongs_to :payment_method
  belongs_to :delivery_method
  belongs_to :user
  has_many :cart_items
end
