class AddActiveToMotors < ActiveRecord::Migration
  def change
    add_column :motors, :active, :boolean, :default => true
  end
end
