#encoding: utf-8
class OrderMailer < ActionMailer::Base
  default from: "admin@zapchasti35.ru"

  def new_order(order)
  	@order = order
  	mail(:to => 'barabanov35rus@yandex.ru', :subject => "Поступила новая заявка")
  end
end
