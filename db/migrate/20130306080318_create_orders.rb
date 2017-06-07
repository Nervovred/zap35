class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
    	t.string :name, :null => false
    	t.string :phone, :null => false
    	t.string :email, :null => false
    	t.text :body
    	t.text :options
    	t.integer :category_id
    	t.integer :status_id
      t.timestamps
    end
  end
end
