class AddPositionToBoats < ActiveRecord::Migration
  def change
    add_column :boats, :position, :integer
  end
end
