class FixBoatPricesAgain < ActiveRecord::Migration
  def up
  	Boat.all.each do |b|
  		if !(b.url_title=='200c')
  			b.price = (b.price.to_i*10).to_s
  			b.save
  		end
  	end
  end

  def down
  end
end
