class CartItem < ActiveRecord::Base
  attr_accessible :cart_id, :cartable_id, :cartable_type, :price, :quantity
  belongs_to :cart
  belongs_to :cartable, :polymorphic => true
  belongs_to :checkout

  def self.create_from_params(cart_id, params)
    current_items = CartItem.where(:cart_id => cart_id, :cartable_id => params[:item_id], :cartable_type => params[:item_type])
    if current_items.empty?
      item = params[:item_type].constantize
      price = item.find(params[:item_id]).price_for_cart
      cart_item = new(:cartable_id => params[:item_id], :cartable_type => params[:item_type], :quantity => 1, :price => price, :cart_id => cart_id)
      cart_item.save
    else
      item = current_items[0]
      item.update_attribute(:quantity, item.quantity + 1)
    end
  end
end
