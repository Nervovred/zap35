class AddCheckoutIdToCartItems < ActiveRecord::Migration
  def change
    add_column :cart_items, :checkout_id, :integer
  end
end
