class AddBuyPriceToCartItems < ActiveRecord::Migration
  def change
    add_column :cart_items, :buy_price, :string
  end
end
