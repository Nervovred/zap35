class ApplicationController < ActionController::Base
  #include SimpleCaptcha::ControllerHelpers  
  protect_from_forgery
  
  def require_http_basic_auth
    authenticate_or_request_with_http_basic do |login, password|
      if login == ENV['BASIC_USER'] && password == ENV['BASIC_PASSWORD']
      	true
      else
        false
      end
    end
  end

  def initialize_options_partials
    @order ||= Order.new
    out={}
    Category.all.each do |cat|
      out[cat.id] = render_to_string(:partial => "common/options#{cat.partial}")
    end
    gon.partials = out
  end


  def current_user
    @current_user ||= User.find_by_auth_token( cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user  

  def current_cart
    if current_user
      @cart ||= current_user.cart
    else
      if session[:cart_token]
        @cart ||= Cart.find_by_session_token(session[:cart_token].to_s)  
        if @cart.nil?
          @cart = Cart.new
          @cart.generate_token(:session_token)
          session[:cart_token] = @cart.session_token
          @cart.save
          @cart
        end
      else
        @cart = Cart.new
        @cart.generate_token(:session_token)
        session[:cart_token] = @cart.session_token
        @cart.save
        @cart
      end
    end
    if @cart
      @cart
    else
      @cart = Cart.new
      @cart.generate_token(:session_token)
      session[:cart_token] = @cart.session_token
      @cart.save
      @cart
    end
  end

  helper_method :current_cart
end
