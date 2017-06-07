# encoding: utf-8

class CheckoutMailer < ActionMailer::Base
  default from: "admin@zapchasti35.ru"

  def new_checkout(checkout)
    @checkout = checkout
    mail(:to => 'barabanov35rus@yandex.ru', :subject => "Поступила новая заявка")
  end
end
