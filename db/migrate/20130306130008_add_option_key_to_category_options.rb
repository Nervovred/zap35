class AddOptionKeyToCategoryOptions < ActiveRecord::Migration
  def change
    add_column :category_options, :option_key, :string
  end
end
