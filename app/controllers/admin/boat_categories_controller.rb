class Admin::BoatCategoriesController < ApplicationController
	layout 'admin'
	before_filter :require_http_basic_auth
	
	def index
		@boat_categories = BoatCategory.order("position")
	end

	def new
		@boat_category = BoatCategory.new
	end

	def create
		@boat_category = BoatCategory.new(params[:boat_category])
		if @boat_category.save
			redirect_to admin_boat_categories_path(@boat_category)
		else
			render :action => 'new'
		end
	end

	def edit
		@boat_category = BoatCategory.find(params[:id])
	end

	def update
		@boat_category = BoatCategory.find(params[:id])
		if @boat_category.update_attributes(params[:boat_category])
			redirect_to admin_boat_categories_path(:id => params[:id])
		else
			render :action => 'edit'
		end
	end

	def destroy
		@boat_category = BoatCategory.find(params[:id])
		@boat_category.destroy
		redirect_to admin_boat_categories_path(:id => params[:id])
	end

	def sort
	  params[:boat_category].each_with_index do |id, index|
	    BoatCategory.update_all({position: index+1}, {id: id})
	  end
  	render nothing: true
	end
end
