class AddActiveToBoats < ActiveRecord::Migration
  def change
    add_column :boats, :active, :boolean, :default => true
  end
end
