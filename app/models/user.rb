#encoding: utf-8
class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :phone
  validates_presence_of :name , :message => 'Укажите имя'
  validates_presence_of :email , :message => 'Укажите Email'
  validates_presence_of :phone , :message => 'Укажите телефон'  
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :email, :message => 'Email уже занят'
  validates :email, :format =>  { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Введите правильный Email" }
  has_one :cart
  has_many :checkouts
  has_many :orders

  before_create do 
    generate_token(:auth_token) 
  end

  after_create do
    create_cart
  end

  def session_cart=(session_token)
    @session_cart=session_token
  end

  def session_cart
    @session_cart
  end

  has_secure_password

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def create_cart
    if !session_cart.nil?
      cart = Cart.find_by_session_token(session_cart)
      cart.update_attribute(:user_id, self.id)
    else
      Cart.create(:user_id => self.id)
    end
  end
  
end
