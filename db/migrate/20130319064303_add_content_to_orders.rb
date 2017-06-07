class AddContentToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :content, :text
  end
end
