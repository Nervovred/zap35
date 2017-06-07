class CreateBoatCategories < ActiveRecord::Migration
  def change
    create_table :boat_categories do |t|
      t.string :title
      t.string :url_title
      t.string :menu_title
      t.text :description
      t.integer :position
    end
    add_column :boat_categories, :options, :hstore
  end
end
