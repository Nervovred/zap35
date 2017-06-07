#encoding: utf-8
class Boat < ActiveRecord::Base
	serialize :options, ActiveRecord::Coders::Hstore
  attr_accessible :boat_category_id, :model, :options, :price, :url_title, :images_attributes, :motor, :title
  belongs_to :boat_category
  acts_as_list scope: :boat_category
  has_many :images, :as => :imageable
  has_many :cart_items, :as => :cartable  
  accepts_nested_attributes_for :images, :allow_destroy => true
  default_scope includes(:boat_category).includes(:images)
  scope :motor, where(:motor => true)
  scope :non_motor, where(:motor => false)
  scope :active, where(:active => true)
  scope :has_carrying, where("CAST (options -> 'carrying' AS FLOAT) IS NOT NULL")

  scope :categories, lambda {|categories| where(:boat_category_id => categories)}
  scope :motor_type, lambda {|motor| where(:motor => motor)}
  scope :price_range, lambda {|price_range| where("CAST (price AS FLOAT) >= #{price_range["minval"]} AND CAST (price AS FLOAT) <= #{price_range["maxval"]}")}  
  scope :length_range, lambda {|length_range| where("CAST (options -> 'length' AS INTEGER) >= #{length_range["minval"]} AND CAST (options -> 'length' AS INTEGER) <= #{length_range["maxval"]}")}
  scope :motor_power_range, lambda {|motor_power_range| where("CAST (options -> 'motor_power' AS FLOAT) >= #{motor_power_range["minval"]} AND CAST (options -> 'motor_power' AS FLOAT) <= #{motor_power_range["maxval"]}")}
  scope :carrying_range, lambda {|carrying_range| where("CAST (options -> 'carrying' AS FLOAT) >= #{carrying_range["minval"]} AND CAST (options -> 'carrying' AS FLOAT) <= #{carrying_range["maxval"]}")}

  before_save :build_title

  self.per_page = 16

  include PgSearch
  multisearchable :against => :title  

  def update_with_options(params)
    params[:options].each do |key, value|
      self.options = (options || {}).merge(key => value)
    end
    params.delete(:options)
    update_attributes(params)
  end

  def options_val(key)
  	options && options[key]
  end

  def cart_item_title
    "Лодка #{boat_category.title} #{model}"
  end

  def price_for_cart
    price
  end

  def buy_price
    "Н/д"
  end  

  def build_title
    title = "Лодка #{boat_category.title} #{model}"
  end
end
