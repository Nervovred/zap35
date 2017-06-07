class CreatePartCategories < ActiveRecord::Migration
  def change
    create_table :part_categories do |t|
      t.string :title

      t.timestamps
    end
  end
end
