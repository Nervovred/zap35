class CreateMotors < ActiveRecord::Migration
  def change
    create_table :motors do |t|
    	t.string :model
    	t.string :power
    	t.integer :strokes
    	t.integer :year
    	t.boolean :newish, :default => false
    	t.integer :category_id
    	t.string :price
      t.timestamps
    end
  end
end
