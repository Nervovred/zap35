class AddMotorToBoats < ActiveRecord::Migration
  def change
    add_column :boats, :motor, :boolean, :default => true
  end
end
