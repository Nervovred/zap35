class Part < ActiveRecord::Base
  attr_accessible :article, :buy_price, :dimension, :margin, :part_category_id, :sell_price, :title, :vendor_id
  belongs_to :vendor
  belongs_to :part_category
  belongs_to :part_subcategory
  has_many :cart_items, :as => :cartable
  scope :fresh, where(:fresh => true)
  default_scope order('title asc')


  include PgSearch
  pg_search_scope :search_by_title,
                  :against => :title,
                  :using => {
                    :tsearch => {:prefix => true, 
                                 :dictionary => 'ru',
                                 :tsvector_column => 'title_tsv'}
                  }

  def build_price_and_margin(buy_price)
  	if buy_price < 500
  		self.sell_price = (buy_price * 1.4).round(0)
      self.margin = 0.4
  	elsif buy_price >= 500 and buy_price < 2000
  		self.sell_price = (buy_price * 1.3).round(0)
      self.margin = 0.3      
  	elsif buy_price >= 2000 and buy_price <= 10000
  		self.sell_price = (buy_price * 1.15).round(0)
      self.margin = 0.15      
  	else 
  		self.sell_price = (buy_price * 1.05).round(0)
      self.margin = 0.05      
  	end
  end

  def price_for_cart
    sell_price
  end

  def cart_item_title
    title
  end

  def self.search(search="", page)
    if !search.blank?
      paginate :per_page => 25, :page => page, :conditions => ['title like ?', "%#{search}%"], :order => 'title'
    else
      paginate :per_page => 25, :page => page, :order => 'title'
    end
  end  
end
