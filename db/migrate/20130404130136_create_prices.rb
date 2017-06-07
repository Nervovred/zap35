class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.integer :vendor_id
      t.integer :part_category_id
      t.attachment :price_file

      t.timestamps
    end
  end
end
