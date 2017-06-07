class PartCategory < ActiveRecord::Base
  attr_accessible :title
  has_many :parts
end
