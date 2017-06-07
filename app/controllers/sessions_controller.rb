#encoding: utf-8
class SessionsController < ApplicationController

  def create
    @title = 'Вход'
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token  
      end
      if session[:cart_token]
        cart = Cart.find_by_session_token(session[:cart_token])
        if user.cart.cart_items.size == 0
          cart.cart_items.each do |ci|
            ci.update_attribute(:cart_id => cart.id)
          end          
        end
      end
      flash[:notice] = "Вы успешно вошли!"
      redirect_to root_url
    else
      flash[:error] = "Неправильный email или пароль"
      render "new"
    end
  end

  def destroy
    cookies.delete(:auth_token)
    session.delete(:cart_token)
    redirect_to root_url, notice: "Вы вышли"
  end
end