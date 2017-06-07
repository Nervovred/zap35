class Admin::SeaProMotorsController < ApplicationController
	layout 'admin'

	def index
		@two_strokes = Motor.includes(:images).order('power ASC').two_strokes.all
		@four_strokes = Motor.includes(:images).order('power ASC').four_strokes.all
	end

	def new
		@motor = Motor.new(:motor_category_id => 2, :newish => true)
		1.times {@motor.images.build}
	end

	def create
		@motor = Motor.new(params[:motor])
		if @motor.save
			redirect_to :action => 'new'
		else
			render :action => 'new'
		end
	end

	def update_prices
		Motor.update(params[:motors].keys, params[:motors].values)
		redirect_to :action => 'index'
	end

	def edit
		@motor = Motor.find(params[:id], :include => :motor_category)
		if @motor.images.empty?
			1.times {@motor.images.build}
		end
	end

	def update
		@motor = Motor.find(params[:id])
		if @motor.update_attributes(params[:motor])
			redirect_to :action => 'index'
		else
			render :action => 'edit'
		end
	end

	def show
		@motor = Motor.find(params[:id])
		respond_to do |format|
			format.js do 
				render :layout => false
			end
		end
	end

	def destroy
		@motor = Motor.find(params[:id])
		@motor.destroy
		redirect_to :action => 'index'
	end

	def toggle_active
		@motor = Motor.find(params[:id])
		if @motor.active?
			@motor.update_attribute(:active, false)
		else
			@motor.update_attribute(:active, true)
		end
		render :nothing => true
	end
end
