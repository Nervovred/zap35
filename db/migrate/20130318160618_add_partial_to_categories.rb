class AddPartialToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :partial, :string
  end
end
