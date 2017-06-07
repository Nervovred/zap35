#encoding: utf-8
class MotorsController < ApplicationController

	def show
		@motor = Motor.find(params[:id])
		@title = "Лодочный мотор #{@motor.motor_category.title} #{@motor.model}"
		respond_to do |format| 
			format.js {
				render :layout => false
			}
			format.html
		end
	end

	def order
		@motor = Motor.find(params[:id])
		@return_if_fail = "/motors/#{@motor.id}/order"
		@order = Order.new(:motor => 'true', :motor_id => @motor.id)
	end

end
