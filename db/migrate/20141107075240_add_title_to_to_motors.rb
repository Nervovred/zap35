class AddTitleToToMotors < ActiveRecord::Migration
  def change
    add_column :motors, :title, :string
    Motor.all.each do |m|
    	m.build_title
    	m.save
    end
  end
end
