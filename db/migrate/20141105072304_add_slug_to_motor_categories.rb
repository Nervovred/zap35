class AddSlugToMotorCategories < ActiveRecord::Migration
  def change
    add_column :motor_categories, :slug, :string
    MotorCategory.first.update_attribute(:slug, 'sea_pro')
  end
end
