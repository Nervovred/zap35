class Category < ActiveRecord::Base
  attr_accessible :position, :title, :partial
  acts_as_list
  has_many :category_options, :order => 'position', :dependent => :destroy
end
