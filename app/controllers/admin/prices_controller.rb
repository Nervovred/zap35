class Admin::PricesController < ApplicationController
	layout 'admin'
	
	def create
		@price = Price.new(params[:price])
		if @price.save
			redirect_to :action => 'index'
		end
	end

	def index
		@prices = Price.all
	end

	def new
		@price = Price.new
	end

	def edit
		@price = Price.find(params[:id])
	end

	def update
		@price = Price.find(params[:id])
		if @price.update_attributes(params[:price])
			redirect_to :action => 'index'
		end
	end

	def destroy
		@price = Price.find(params[:id])
		@price.destroy
		redirect_to :action => 'index'
	end

	def calculate
		@price = Price.find(params[:id])
		if @price.price_file_updated_at
			@price.add_parts
		end
		redirect_to :action => 'index'
	end

end
