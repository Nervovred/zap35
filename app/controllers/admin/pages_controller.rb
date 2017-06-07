class Admin::PagesController < ApplicationController
	layout 'admin'
	before_filter :require_http_basic_auth
	
	def index
		@pages = Page.all
	end

	def new
		@page = Page.new
	end

	def create
		@page = Page.new(params[:page])
		if @page.save
			redirect_to admin_pages_path
		else
			render :action => 'new'
		end
	end

	def edit
		@page = Page.find(params[:id])
	end

	def update
		@page = Page.find(params[:id])
		if @page.update_attributes(params[:page])
			redirect_to admin_pages_path
		else
			render :action => 'edit'
		end
	end

	def destroy
		@page = Page.find(params[:id])
		@page.destroy!
		redirect_to admin_pages_path
	end

end
