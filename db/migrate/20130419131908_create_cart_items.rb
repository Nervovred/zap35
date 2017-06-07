class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer :cart_id
      t.integer :cartable_id
      t.string :cartable_type
      t.integer :quantity
      t.integer :price
      t.integer :total
      t.timestamps
    end
  end
end
