class FixBoatPrices < ActiveRecord::Migration
  def up
  	Boat.all.each do |b|
  		b.price = b.price[0..-3].split(' ').join('').to_i
  		b.save
  	end
  end

  def down
  end
end
