class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.integer :vendor_id
      t.integer :part_category_id
      t.string :article
      t.string :title
      t.string :dimension
      t.decimal :buy_price
      t.decimal :margin
      t.integer :sell_price

      t.timestamps
    end
  end
end
