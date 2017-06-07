class AddOptionsToMotors < ActiveRecord::Migration
  def change
    add_column :motors, :options, :hstore
  end
end
