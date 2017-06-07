class ModifyBoatCarrying < ActiveRecord::Migration
  def up
  	BoatCategory.find(1).boats.each do |b|
  		b.options['carrying'] = b.options['carrying'][0..-3]
  		b.save
  	end
  	BoatCategory.find(2).boats.each do |b|
  		b.options['carrying'] = b.options['carrying'][0..-3]
  		b.save
  	end
  end

  def down
  end
end
