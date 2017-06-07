class BoatCategory < ActiveRecord::Base
	acts_as_list
  attr_accessible :description, :menu_title, :options, :title, :url_title, :position
  has_many :boats


  def options_hash
  	eval(options)
  end

end
