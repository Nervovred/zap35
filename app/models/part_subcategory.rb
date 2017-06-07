class PartSubcategory < ActiveRecord::Base
  attr_accessible :title
  has_many :parts
end
