#encoding: utf-8
class HomeController < ApplicationController
	before_filter :initialize_options_partials, :only => [:index]

  def index
  	@title = 'Главная'
  	@order = Order.new
  	@return_if_fail = 'home/index'
  	@fail = true
  end

  def thank_you
    @title = 'Спасибо!'
  end

  def search
    @results = PgSearch.multisearch(params[:search_input])
  end
end
