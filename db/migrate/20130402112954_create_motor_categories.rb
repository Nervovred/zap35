class CreateMotorCategories < ActiveRecord::Migration
  def change
    create_table :motor_categories do |t|
      t.string :title

      t.timestamps
    end
    MotorCategory.create(:title => 'Sea-Pro')
  end
end
