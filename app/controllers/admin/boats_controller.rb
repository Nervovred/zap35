class Admin::BoatsController < ApplicationController
	layout 'admin'
	before_filter :require_http_basic_auth

	def index
		@boats = Boat.order("position")
		@boat_categories = BoatCategory.order("position")
	end

	def new
		@boat = Boat.new
		@boat_categories = BoatCategory.order("position")
		@boat.images.build
	end

	def edit
		@boat = Boat.find(params[:id], :include => :boat_category)
		@boat_category = @boat.boat_category
		if @boat.images.empty?
			@boat.images.build
		end		
	end

	def update
		@boat = Boat.find(params[:id])
		if @boat.update_with_options(params[:boat])
			redirect_to :action => 'index'
		else
			render :action => 'edit'
		end
	end

	def update_prices
		Boat.update(params[:boats].keys, params[:boats].values)
		redirect_to :action => 'index'
	end


	def destroy
		@boat = Boat.find(params[:id])
		@boat.destroy
		redirect_to :action => 'index'
	end

	def create
		@boat = Boat.new(params[:boat])
		if @boat.save
			redirect_to :action => 'index'
		else
			render :action => 'new'
		end
	end

	def show
		@boat = Boat.find(params[:id], :include => :boat_category)
	end

	def sort
	  params[:boat].each_with_index do |id, index|
	    Boat.update_all({position: index+1}, {id: id})
	  end
  	render nothing: true
	end

end
