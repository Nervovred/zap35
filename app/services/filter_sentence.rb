# encoding: utf-8
class FilterSentence
	attr_reader :out
	def initialize(params, model)
		construct_sentence(params, model)
		self
	end

	def construct_sentence(params, model)
		@out = ["Вы ищете"]
		self.public_send("construct_#{model}", params)
	end

	def construct_motor(params)
		min_power = Motor.active.select('power').order('power ASC').first.power.to_f.floor.to_s
		max_power = Motor.active.select('power').order('power DESC').first.power.to_f.floor.to_s
		min_price = (Motor.active.select('price').order('CAST (price AS FLOAT) ASC').first.price.to_f / 1000).floor.to_s
		max_price = (Motor.active.select('price').order('CAST (price AS FLOAT) DESC').first.price.to_f / 1000).ceil.to_s				
		if params[:strokes_type] && !params[:strokes_type].empty? && params[:strokes_type].size == 1
			if params[:strokes_type][0] == "2"
				@out << "двухтактные"
			elsif params[:strokes_type][0] == "4"
				@out << "четырехтактные"
			end
		end
		@out << "лодочные моторы"
		if params[:categories] && !params[:categories].empty?
			@out << MotorCategory.select('title').where(:id => params[:categories]).collect(&:title).join(', ') + ' '
		end
		if params[:power_range] && !params[:power_range].empty?
			if params[:power_range][:minval] != min_power
				temp = "мощностью от #{params[:power_range][:minval]} л.с. "
				if params[:power_range][:maxval] != max_power
					temp += "до #{params[:power_range][:maxval]} л.с."
				end
			else
				if params[:power_range][:maxval] != max_power
					temp += "мощностью до #{params[:power_range][:maxval]} л.с."
				end
			end
			@out << temp
		end
		if params[:price_range] && !params[:price_range].empty?
			if params[:price_range][:minval] != min_price
				temp = "ценой от #{params[:price_range][:minval]} р. "
				if params[:price_range][:maxval] != max_price
					temp += "до #{params[:price_range][:maxval]} р. "
				end
			else
				if params[:price_range][:maxval] != max_price
					temp += "ценой до #{params[:price_range][:maxval]} р."
				end
			end
			@out << temp
		end		
		if @out.size >=6
			@out.insert(5, ' и ')
		end
		@out = @out.join(' ')
	end

	def to_s
		@out
	end

end