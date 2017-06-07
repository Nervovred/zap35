class CreatePartSubcategories < ActiveRecord::Migration
  def change
    create_table :part_subcategories do |t|
    	t.string :title
      t.timestamps
    end
  end
end
