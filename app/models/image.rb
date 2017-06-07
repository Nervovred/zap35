class Image < ActiveRecord::Base
  attr_accessible :imageable_id, :imageable_type, :picture
  belongs_to :imageable, :polymorphic => true
  has_attached_file :picture, :styles => { :high => "800x800>", :cell => '180x135>', :thumb => "96x96>", :tiny => '48x48>' }, :url => "/system/:hash.:extension", :hash_secret => "JVgJvoBtjnT1djGrseZc" 
	validates :picture, :attachment_presence => true
end
