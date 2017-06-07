class AddFreshToParts < ActiveRecord::Migration
  def change
    add_column :parts, :fresh, :boolean, :default => true
  end
end
