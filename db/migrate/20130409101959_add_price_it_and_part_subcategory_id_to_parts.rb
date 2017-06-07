class AddPriceItAndPartSubcategoryIdToParts < ActiveRecord::Migration
  def change
    add_column :parts, :price_id, :integer
    add_column :parts, :part_subcategory_id, :integer
  end
end
