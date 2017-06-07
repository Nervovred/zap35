class AddMarlinMotors < ActiveRecord::Migration
  def up
  	m = MotorCategory.new(:title => 'Marlin', :slug => 'marlin')
  	m.save
  end

  def down
  	m = MotorCategory.find_by_slug('marlin')
  	m.destroy
  end
end
