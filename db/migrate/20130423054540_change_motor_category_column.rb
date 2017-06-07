class ChangeMotorCategoryColumn < ActiveRecord::Migration
  def up
    rename_column :motors, :category_id, :motor_category_id
  end

  def down
    rename_column :motors, :motor_category_id, :category_id
  end
end
