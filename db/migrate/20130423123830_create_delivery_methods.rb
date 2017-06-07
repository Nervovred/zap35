class CreateDeliveryMethods < ActiveRecord::Migration
  def change
    create_table :delivery_methods do |t|
      t.string :title

      t.timestamps
    end
  end
end
