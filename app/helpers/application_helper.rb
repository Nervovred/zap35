module ApplicationHelper

	def construct_options_for_order
		categories = Category.all(:include => :category_options)
		out_hash={}
		categories.each do |category|
			out=""
			category.category_options.each do |opt|
				case opt.kind
				when "string"
					out+="<p><label for='order_options_#{opt.option_key}'>#{opt.title}</label>"
					out+="<input id='order_options_#{opt.option_key}' name='order[options][#{opt.option_key}]' size='30' type='text'></p>"
				when "text"
					out+="<p><label for='order_options_#{opt.option_key}'>#{opt.title}</label><br/>"
					out+="<textarea cols='40' id='order_options_#{opt.option_key}' name='order[options][#{opt.option_key}]' rows=''></textarea>"
				end
			end
			out_hash[category.id] = out
		end
		out_hash
	end

	def construct_errors(errors_hash, model_name='user')
		errors = errors_hash.inject({}) { |h, (k, v)| h["##{model_name}_#{k.to_s}"] = v; h }
		errors
	end


	def is_active?(uri)
		if request.path.match(uri) || (@return_if_fail && @return_if_fail.match(uri))
			"active"
		else
			""
		end
	end

	def is_current?(uri)
		if request.path.match(uri) || (@return_if_fail && @return_if_fail.match(uri))
			"current"
		else
			""
		end
	end	

	def is_root?(request)
		if request[:controller] == 'home' && request[:action] == 'index'
			"first current"
		else
			"first"
		end
	end

	def page_mark
		res = []
		if request[:controller] == 'home' && request[:action] == 'index'
			res << '#home'
		else
			res << "##{request.path[1..-1]}"
		end
		res.join(', ')
	end

end
