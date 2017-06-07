class AdminController < ApplicationController
	layout 'admin'
	before_filter :require_http_basic_auth

  def index
  end
end
