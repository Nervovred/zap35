class AddOptionsToOrders < ActiveRecord::Migration
  def change
  	remove_column :orders, :options
    add_column :orders, :options, :hstore
  end
end
