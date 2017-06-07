class CreateCheckouts < ActiveRecord::Migration
  def change
    create_table :checkouts do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.integer :user_id
      t.decimal :total
      t.integer :payment_method_id
      t.integer :delivery_method_id
      t.string :status

      t.timestamps
    end
  end
end
