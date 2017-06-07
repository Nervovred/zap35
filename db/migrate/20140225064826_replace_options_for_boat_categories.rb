class ReplaceOptionsForBoatCategories < ActiveRecord::Migration
  def up
  	remove_column :boat_categories, :options
  	add_column :boat_categories, :options, :text
  end

  def down
  	remove_column :boat_categories, :options
  	add_column :boat_categories, :options, :hstore
  end
end
