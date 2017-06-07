class ChangeMotorPowerColumn < ActiveRecord::Migration
  def up
    execute "ALTER TABLE motors ALTER COLUMN power TYPE numeric(10,1) USING power::numeric"
  end

  def down
  end
end
