# encoding: utf-8

class AddHumanNamesToMotorCategories < ActiveRecord::Migration
  def up
    add_column :motor_categories, :human_names, :hstore
    execute "CREATE INDEX motor_categories_human_names ON motor_categories USING GIN(human_names)"
    m = MotorCategory.find_by_slug("sea_pro")
    m.add_human_names({'max_rpm' => 'Максимальные обороты', 'engine_type' => 'Тип двигателя', 
											'volume' => 'Объём, см куб.', 'piston' => 'Диаметр / ход поршня, мм',
											'start_system' => 'Система запуска', 'ignition_system' => 'Система зажигания',
											'cooling_system' => 'Система охлаждения', 'control' => 'Управление',
											'trancemission' => 'Передачи редуктора', 'gear_ratio' => 'Передаточное отношение редуктора',
											'fuel_tank' => 'Объём топливного бака, л', 'dimensions' => 'Габариты, мм', 'weight' => 'Вес, кг'})
    m.save
  end

  def down
  	execute "DROP INDEX motor_categories_human_names"
  	remove_column :motor_categories, :human_names
  end
end
