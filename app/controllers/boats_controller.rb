#encoding: utf-8
class BoatsController < ApplicationController

	def index
		@title = "Лодки ПВХ"
		@categories = BoatCategory.order('position').preload('boats')
	end

	def rework
		@min_motor_power = Boat.active.select("options").order("cast (options -> 'motor_power' as float) asc").first.options["motor_power"]
		@max_motor_power = Boat.active.select("options").order("cast (options -> 'motor_power' as float) desc").first.options["motor_power"]
		@min_length = Boat.active.select("options").order("cast (options -> 'length' as float) asc").first.options["length"]
		@max_length = Boat.active.select("options").order("cast (options -> 'length' as float) desc").first.options["length"]
		@min_carrying = Boat.active.has_carrying.select("options").order("cast (options -> 'carrying' as float) asc").first.options["carrying"]
		@max_carrying = Boat.active.has_carrying.select("options").order("cast (options -> 'carrying' as float) desc").first.options["carrying"]		
		@min_price = (Boat.active.select('price').order('CAST (price AS FLOAT) ASC').first.price.to_f / 1000).floor
		@max_price = (Boat.active.select('price').order('CAST (price AS FLOAT) DESC').first.price.to_f / 1000).ceil		
		@categories = BoatCategory.all
		@title = 'Лодки ПВХ'
		if params[:filter] && !filtering_params(params[:filter]).empty?
			@filtered = params[:filter]
			@boats = Boat.where(nil)
			filtering_params(@filtered).each do |key, value|
			  @boats = @boats.public_send(key, value) if value.present?
			end			
			@boats = @boats.active.order('CAST (price AS FLOAT) ASC') if @boats
		else
			@boats = Boat.active.order('CAST (price AS FLOAT) ASC')
		end
		@boats = @boats.paginate(:page => params[:page])
		respond_to do |format|
			format.js
			format.html
		end
	end

	def category
		@category = BoatCategory.find_by_url_title(params[:category], :include => :boats)
		@motor_boats = @category.boats.motor
		@non_motor_boats = @category.boats.non_motor
		@title = @category.menu_title
	end

	def show
		if !params[:url_title].nil?
			@category = BoatCategory.find_by_url_title(params[:category])
			@boat = Boat.find_by_url_title(params[:url_title])
		else
			@boat = Boat.find_by_id(params[:id], :include => :boat_category)
			@category = @boat.boat_category
		end
		respond_to do |format|
			format.js
			format.html
		end
	end

	def filtering_params(params)
	  params.slice(:categories, :motor_type, :length_range, :motor_power_range, :price_range, :carrying_range)
	end	

end
