# encoding: utf-8

class UserMailer < ActionMailer::Base
  default from: "admin@zapchasti35.ru"

  def register(user)
    @user = user
    mail(:to => user.email, :subject => "Вы успешно зарегистрированы!")
  end

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Сброс пароля"
  end
end
