class MotorCategory < ActiveRecord::Base
	serialize :human_names, ActiveRecord::Coders::Hstore
	serialize :options_order
  attr_accessible :title, :slug, :human_names, :options_order
  has_many :motors, :order => 'price ASC'
  has_many :two_stroke_motors, :class_name => "Motor", :foreign_key => "motor_category_id", :conditions => {:strokes => 2}
  has_many :four_stroke_motors, :class_name => "Motor", :foreign_key => "motor_category_id", :conditions => {:strokes => 4}

  def add_human_names(hash)
  	self.human_names = {}
  	hash.each do |key,value|
  		self.human_names[key] = value
  	end

  end

  def add_human_name(key, value)
  	self.human_names = (human_names || {})[key] = value
  end

  def human_name_for(key)
  	human_names && human_names[key]
  end
end
