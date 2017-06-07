class Admin::VendorsController < ApplicationController
	layout 'admin'

	def index
		@vendors = Vendor.all
	end

	def new
		@vendor = Vendor.new
	end

	def create
		@vendor = Vendor.new(params[:vendor])
		if @vendor.save
			redirect_to admin_vendors_path
		else
			render :action => 'new'
		end
	end

	def edit
		@vendor = Vendor.find(params[:id])
	end

	def update
		@vendor = Vendor.find(params[:id])
		if @vendor.update_attributes(params[:vendor])
			redirect_to admin_vendors_path
		else
			render :action => 'edit'
		end
	end

	def destroy
		@vendor = Vendor.find(params[:id])
		@vendor.destroy
		redirect_to admin_vendors_path
	end

	def show
		@vendor = Vendor.find(params[:id])
		if !@vendor.prices.empty?
			@price = @vendor.prices[0]
		else
			@price = @vendor.prices.build
		end
	end
end
