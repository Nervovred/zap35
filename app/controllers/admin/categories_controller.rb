class Admin::CategoriesController < ApplicationController
	layout 'admin'
	before_filter :require_http_basic_auth

	def index
		@categories = Category.order("position")
	end

	def new
		@category = Category.new
	end

	def edit
		@category = Category.find(params[:id])
	end

	def update
		@category = Category.find(params[:id])
		if @category.update_attributes(params[:category])
			redirect_to :action => 'index'
		else
			render :action => 'edit'
		end
	end

	def destroy
		@category = Category.find(params[:id])
		@category.destroy
		redirect_to :action => 'index'
	end

	def create
		@category = Category.new(params[:category])
		if @category.save
			redirect_to :action => 'index'
		else
			render :action => 'new'
		end
	end

	def show
		@category = Category.find(params[:id], :include => :category_options)
	end

	def sort
	  params[:category].each_with_index do |id, index|
	    Category.update_all({position: index+1}, {id: id})
	  end
  	render nothing: true
	end
end
