# encoding: utf-8

class UsersController < ApplicationController

  def new
    @title = 'Регистрация'
    @user = User.new
    respond_to do |format|
      if request.xhr?
        format.js do
          render :layout => false
        end
      else
        format.html
      end
    end
  end
  
  def create
    @user = User.new(params[:user])
    if session[:cart_token]
      @user.session_cart = session[:cart_token]
    end    
    #if @user.save
     # UserMailer.register(@user).deliver
     # cookies[:auth_token] = @user.auth_token
     # redirect_to root_url, notice: "Спасибо за регистрацию!"
    #else
     # flash[:error] = 'Произошла ошибка'
      render "new"
    #end
  end  

  def email_check
    respond_to do |format| 
      format.js do 
        @user = User.find_by_email(params["fieldValue"])
        render :json => ["user_email", !!@user.nil?]
      end
    end
  end

end
