#encoding: utf-8

require 'roo'

class Price < ActiveRecord::Base
  attr_accessible :part_category_id, :price_file, :vendor_id
  attr_accessor :current_cat
  has_attached_file :price_file
  belongs_to :part_category
  belongs_to :vendor

  def add_parts
  	price = Roo::Spreadsheet.open(self.price_file.path)
  	line_count = price.count
  	(13..price.count).each do |i|
  		if price.row(i)[1].nil? || price.row(i)[1].to_s.strip == ''
        if price.row(i+1)[0].strip == '----//----' 
  			  current_row = price.row(i+1)
        else
          self.current_cat = PartSubcategory.find_or_create_by_title(price.row(i)[0].strip)
        end
  		elsif !price.row(i)[1].nil?
  			current_row = price.row(i)
  		else
  			current_row = nil
  		end
  		if current_row
  			p=Part.find_or_initialize_by_vendor_id_and_article(self.vendor_id, current_row[1].to_i)
  			p.title = current_row[0].strip
        Orthography::REPLACES.each {|rep| p.title.gsub!(rep[0],rep[1])}
  			p.dimension = current_row[3].strip
  			p.buy_price = current_row[2].to_f
  			p.article = current_row[1].to_i
  			p.build_price_and_margin(p.buy_price)
        p.vendor_id = self.vendor_id
  			p.part_category_id = self.part_category_id
        if self.current_cat
          p.part_subcategory_id = self.current_cat.id
        end
  			p.save
  		end
  	end
    Part.update_all('fresh = false', ['updated_at < ?', self.price_file_updated_at.midnight])
    Part.destroy_all("title='----//----'")
  end

  def file_loaded
  	if price_file_updated_at 
  		price_file_updated_at.strftime("%d %B %y")
  	else
  		"Нет"
  	end
  end

end
