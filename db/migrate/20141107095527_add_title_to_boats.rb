# encoding: utf-8

class AddTitleToBoats < ActiveRecord::Migration
  def change
    add_column :boats, :title, :string
    Boat.all.each do |boat|
    	boat.title = "Лодка #{boat.boat_category.title} #{boat.model}"
    	boat.save
    end
  end
end
