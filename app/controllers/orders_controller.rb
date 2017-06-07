class OrdersController < ApplicationController

	def create
		@order = Order.new(params[:order])
		if current_user
			@order.user = current_user
			@order.name, @order.email, @order.phone = current_user.name, current_user.email, current_user.phone
		end
		if verify_recaptcha(model: @order) && @order.save
			OrderMailer.new_order(@order).deliver
			redirect_to '/thank_you'
		else
#			if !@order.valid_with_captcha?
#				@captcha_fail = true
#			end
			if params[:return_if_fail]
				if params[:return_if_fail].match(/\/motors\/(\d+)\/order/)
					@motor = Motor.find(params[:return_if_fail].match(/\/motors\/(\d+)\/order/)[1])
					@order = Order.new(params[:order])
					@vendor = params[:vendor]
					@return_if_fail = "/motors/#{@motor.id}/order"
					render '/motors/order'
				else
					@return_if_fail = params[:return_if_fail]
					render params[:return_if_fail]
				end
			else
				render 'home/index'
			end
		end
	end

	def refresh_captcha
		render :layout => false
	end

	def check_captcha
		@value = simple_captcha_ajax_valid?
		respond_to do |format|
			format.js do
				render :layout => false
			end
		end
	end

end
