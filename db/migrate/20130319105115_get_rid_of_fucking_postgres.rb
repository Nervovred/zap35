class GetRidOfFuckingPostgres < ActiveRecord::Migration
  def up
  	change_column :orders, :name, :string, :null => false, :default => ''
  	change_column :orders, :phone, :string, :null => false, :default => ''
  	change_column :orders, :email, :string, :null => false, :default => ''
  end

  def down
  end
end
