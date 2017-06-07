class CreateBoats < ActiveRecord::Migration
  def change
    create_table :boats do |t|
      t.string :model
      t.string :url_title
      t.integer :boat_category_id
      t.string :price

      t.timestamps
    end
    add_column :boats, :options, :hstore
  end
end
