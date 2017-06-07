#encoding: utf-8
class PagesController < ApplicationController

	def show
	end

	def about
		@title = 'О нас'
	end

	def zapchasti
		@title = 'Запчасти'
		@order = Order.new
	end

	def zapchasti_uaz
		@title = 'Запчасти УАЗ'
		@part_category = PartCategory.where(:title => 'УАЗ').first
		if params[:page]
			page = params[:page]
		else
			page = 1
		end
		if params[:search] && !params[:search].strip.empty?
			@parts = Part.fresh.where(:part_category_id => @part_category.id).search_by_title(params[:search]).page(page)
		else
			@parts = Part.fresh.where(:part_category_id => @part_category.id).page(page)
		end
	end	

	def zapchasti_vaz
		@title = 'Запчасти ВАЗ'
		@part_category = PartCategory.where(:title => 'ВАЗ').first
		if params[:page]
			page = params[:page]
		else
			page = 1
		end
		if params[:search] && !params[:search].strip.empty?
			@parts = Part.fresh.where(:part_category_id => @part_category.id).search_by_title(params[:search]).page(page)
		else
			@parts = Part.fresh.where(:part_category_id => @part_category.id).page(page)
		end
	end

	def zapchasti_dlya_inomarok
		@title = 'Запчасти для иномарок'
		category = Category.where(:partial => '_car_parts').first
		@order=Order.new(:category_id => category.id)
		@return_if_fail = 'pages/zapchasti_dlya_inomarok'
	end

	def zapchasti_dlya_lodochnih_motorov
		@title = 'Запчасти для лодочных моторов'
		category = Category.where(:partial => '_outboard_motor').first
		@order = Order.new(:category_id => category.id)
		@return_if_fail = 'pages/zapchasti_dlya_lodochnih_motorov'
	end

	def zapchasti_dlya_kitaiskih_avtobusov
		@title = 'Запчасти для китайских автобусов'
		category = Category.where(:partial => '_china_bus').first
		@order=Order.new(:category_id => category.id)
		@return_if_fail = 'pages/zapchasti_dlya_kitaiskih_avtobusov'
	end

	def oplata
		@title = 'Оплата'
	end

	def dostavka
		@title = 'Доставка'
	end

	def motors
		if params[:slug]
			@categories = [MotorCategory.find_by_slug(params[:slug], :include => [:two_stroke_motors, :four_stroke_motors])]
			@title = "Лодочные моторы #{@categories[0].title}"
		else
			@categories = MotorCategory.order('id').preload([:two_stroke_motors, :four_stroke_motors])
			@title = 'Лодочные моторы'
		end
	end

	def motors_rework
		@min_power = Motor.active.select('power').order('power ASC').first.power.to_f.floor
		@max_power = Motor.active.select('power').order('power DESC').first.power.to_f.floor
		@min_price = (Motor.active.select('price').order('CAST (price AS FLOAT) ASC').first.price.to_f / 1000).floor
		@max_price = (Motor.active.select('price').order('CAST (price AS FLOAT) DESC').first.price.to_f / 1000).ceil		
		@categories = MotorCategory.all
		@title = 'Лодочные моторы'
		if params[:filter] && !filtering_params(params[:filter]).empty?
			@filtered = params[:filter]
			@motors = Motor.where(nil)
			filtering_params(@filtered).each do |key, value|
			  @motors = @motors.public_send(key, value) if value.present?
			end			
			@motors = @motors.active.order('CAST (price AS FLOAT) ASC') if @motors
			#@sentence = FilterSentence.new(filtering_params(@filtered), 'motor')
		else
			@motors = Motor.active.order('CAST (price AS FLOAT) ASC')
		end
		@motors = @motors.paginate(:page => params[:page])
		respond_to do |format|
			format.js
			format.html
		end
	end

	def lodochnie_motory
		@title = 'Лодочные моторы'
		@categories = MotorCategory.order('id').preload([:two_stroke_motors, :four_stroke_motors])
	end

	def filtering_params(params)
	  params.slice(:categories, :strokes_type, :price_range, :power_range)
	end	

end
