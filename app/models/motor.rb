# encoding: utf-8
class Motor < ActiveRecord::Base
	serialize :options, ActiveRecord::Coders::Hstore
  attr_accessible :model, :power, :strokes, :price, :year, :newish, :motor_category_id, :motor_category, :images_attributes, :options_order,
                  :options, :motor_category_id, :active, :title
  belongs_to :motor_category
  has_many :images, :as => :imageable
  has_many :cart_items, :as => :cartable
  before_save :build_title
  accepts_nested_attributes_for :images, :allow_destroy => true
  scope :sea_pro, where(:motor_category_id => 1)
  scope :two_strokes, where(:strokes => 2)
  scope :four_strokes, where(:strokes => 4)
  scope :active, where(:active => true)
  scope :by_price, order("CAST (price AS FLOAT) ASC")

  scope :categories, lambda {|categories| where(:motor_category_id => categories)}
  scope :strokes_type, lambda {|strokes_type| where(:strokes => strokes_type)}
  scope :price_range, lambda {|price_range| where("CAST (price AS FLOAT) >= #{price_range["minval"]} AND CAST (price AS FLOAT) <= #{price_range["maxval"]}")}
  scope :power_range, lambda {|power_range| where("power >= #{power_range["minval"]} AND power <= #{power_range["maxval"]}")}

  default_scope includes(:motor_category).includes(:images)

  include PgSearch
  multisearchable :against => :title

  self.per_page = 16

  def options=(hash)
    hash.each do |k,v|
      (options || {})[k] = v
    end
  end

  def cart_item_title
    "Лодочный мотор #{motor_category.title} #{model}"
  end

  def price_for_cart
    price
  end

  def buy_price
    "Н/д"
  end

  def build_title
    title = "Лодочный мотор #{motor_category.title} #{model}"
  end

  def title 
    "Лодочный мотор #{motor_category.title} #{model}"
  end

end
