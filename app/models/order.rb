#encoding: utf-8
class Order < ActiveRecord::Base
	serialize :options, ActiveRecord::Coders::Hstore
  # apply_simple_captcha :message => "Неправильный код"
  attr_accessible :name, :phone, :email, :content, :subject, :options, :category_id,
   :captcha, :captcha_key
  validates_presence_of :name , :message => 'Укажите имя'
  validates_presence_of :email , :message => 'Укажите Email'
  validates_presence_of :phone , :message => 'Укажите телефон'
  validates :email, :format =>  { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Введите правильный Email" }
  belongs_to :user
  belongs_to :category

  %w[brand model year vin engine_model shield motor motor_id].each do |key|
    attr_accessible key
    scope "has_#{key}", lambda { |value| where("options @> hstore(?, ?)", key, value) }
    
    define_method(key) do
      options && options[key]
    end
  
    define_method("#{key}=") do |value|
      self.options = (options || {}).merge(key => value)
    end
  end

  OPTIONS_HUMAN_NAMES={'brand' => 'Марка', 'model' => 'Модель', 
    'VIN' => 'VIN', 'year' => 'Год выпуска', 'engine_model' => 'Модель двигателя',
    'subject' => 'Запчасть', 'content' => 'Подробности'}
end
