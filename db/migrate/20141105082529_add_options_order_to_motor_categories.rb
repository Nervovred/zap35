class AddOptionsOrderToMotorCategories < ActiveRecord::Migration
  def change
    add_column :motor_categories, :options_order, :text
    m = MotorCategory.find_by_slug('sea_pro')
    m.options_order = %w[max_rpm engine_type volume piston start_system ignition_system cooling_system 
  	 control trancemission gear_ratio fuel_tank dimensions weight]
  	m.save
  end
end
