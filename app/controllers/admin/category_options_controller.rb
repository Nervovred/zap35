class Admin::CategoryOptionsController < ApplicationController
	layout 'admin'
	before_filter :require_http_basic_auth
	
	def new
		@category = Category.find(params[:category_id])
		@option = @category.category_options.build
	end

	def create
		@category = Category.find(params[:category_id])
		@category.category_options.build(params[:category_option])
		if @category.save
			redirect_to admin_category_path(@category)
		else
			render :action => 'new'
		end
	end

	def edit
		@category = Category.find(params[:category_id])
		@option = CategoryOption.find(params[:id])
	end

	def update
		@option = CategoryOption.find(params[:id])
		if @option.update_attributes(params[:category_option])
			redirect_to admin_category_path(:id => params[:category_id])
		else
			render :action => 'edit'
		end
	end

	def destroy
		@option = CategoryOption.find(params[:id])
		@option.destroy
		redirect_to admin_category_path(:id => params[:category_id])
	end

	def sort
	  params[:category_option].each_with_index do |id, index|
	    CategoryOption.update_all({position: index+1}, {id: id})
	  end
  	render nothing: true
	end
end
