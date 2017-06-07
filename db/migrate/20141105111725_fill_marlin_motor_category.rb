# encoding: utf-8

class FillMarlinMotorCategory < ActiveRecord::Migration
  def up
  	m = MotorCategory.find_by_slug('marlin')
  	m.add_human_names({'max_rpm' => 'Максимальные обороты', 'idle_rpm' => 'Холостой ход, об/мин', 'generator' => 'Выход с генератора, Вольт/Ампер',
  										'engine_type' => 'Тип двигателя', 'mixture' => 'Система питания горючей смеси', 'guarantee' => 'Гарантия',
											'volume' => 'Объём, см куб.', 'piston' => 'Диаметр / ход поршня, мм', 'complect' => 'Дополнительная комплектация',
											'different_reg' => 'Система регулировки дифферента', 'start_system' => 'Система запуска', 'ignition_system' => 'Система зажигания',
											'cooling_system' => 'Система охлаждения', 'control' => 'Управление', 'length' => 'Длина дейвуда, мм',
											'trancemission' => 'Передачи редуктора', 'gear_ratio' => 'Передаточное отношение редуктора',
											'fuel_tank' => 'Объём топливного бака, л', 'dimensions' => 'Габариты, мм', 'weight' => 'Вес, кг'})
  	m.options_order = %w[engine_type volume piston gear_ratio max_rpm idle_rpm generator length weight start_system control different_reg fuel_tank mixture complect guarantee]
  	m.save
  end

  def down
  end
end
