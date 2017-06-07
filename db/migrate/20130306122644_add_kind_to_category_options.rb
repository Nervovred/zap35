class AddKindToCategoryOptions < ActiveRecord::Migration
  def change
    add_column :category_options, :kind, :string
  end
end
