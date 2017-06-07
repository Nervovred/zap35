# encoding: utf-8

class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url, :notice => "Письмо с инструкцией по сбросу пароля отправлено по указанному адресу."
  end

  def edit
    @title = 'Сброс пароля'
    @user = User.find_by_password_reset_token!(params[:id])
  end  
  
  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Ссылка устарела"
    elsif @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Пароль успешно сброшен"
    else
      render :edit
    end
  end  
end
