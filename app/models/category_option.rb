#encoding: utf-8

class CategoryOption < ActiveRecord::Base

	SELECT_OPTIONS_ARRAY=[['Строка', 'string'], ['Дата', 'date'], ['Текст', 'text']]
	SELECT_OPTIONS_HASH={'string' => 'Строка', 'date' => 'Дата', 'text' => 'Текст'}

  attr_accessible :category_id, :position, :title, :kind, :option_key
  belongs_to :category
  acts_as_list scope: :category
end
