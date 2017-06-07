class ModifyLengthOfBoats < ActiveRecord::Migration
  def up
  	BoatCategory.find(1).boats.each do |b|
  		b.options['length']='290'
  		b.save
  	end
  	BoatCategory.find(2).boats.each do |b|
  		b.options['length']=b.options['length'][0..-4]
  		b.save
  	end
  	BoatCategory.find(3).boats.each do |b|
  		b.options['length']=b.options['length'].scan(/\d+/).join.to_i * 10
  		b.save
  	end
  end

  def down
  end
end
