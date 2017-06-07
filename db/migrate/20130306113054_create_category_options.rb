class CreateCategoryOptions < ActiveRecord::Migration
  def change
    create_table :category_options do |t|
      t.integer :category_id
      t.string :title
      t.integer :position

      t.timestamps
    end
  end
end
