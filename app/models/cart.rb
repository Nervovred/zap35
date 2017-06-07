class Cart < ActiveRecord::Base
  attr_accessible :session_token
  belongs_to :user
  has_many :cart_items

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Cart.exists?(column => self[column])
  end

  def total_items
    cart_items.blank? ? 0 : cart_items.sum(&:quantity)
  end

  def total_sum
    cart_items.collect{|ci| ci.quantity*ci.price}.sum
  end
end
