class ModifyMotorPowerBoats < ActiveRecord::Migration
  def up
  	BoatCategory.find(1).boats.each do |b|
  		b.options['motor_power']=b.options['motor_power'][0..-6]
  		b.save
  	end
  	BoatCategory.find(2).boats.each do |b|
  		b.options['motor_power']=b.options['motor_power'][0..-6].gsub(',','.')
  		b.save
  	end
  	Boat.all.each do |b|
  		b.options['motor_power']=b.options['motor_power'].gsub(',','.')
  		b.save
  	end  	
  end

  def down
  end
end
