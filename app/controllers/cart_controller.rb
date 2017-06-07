#encoding: utf-8
class CartController < ApplicationController

  def index
    @title = 'Корзина'
    @cart = current_cart
  end

  def add
    @cart = current_cart
    CartItem.create_from_params(@cart.id, params)
    respond_to do |format|
      format.js
      format.html {redirect_to cart_path}
    end 
  end

  def remove
    @cart = current_cart
    @ci = CartItem.find(params[:id])
    if @ci.cart_id.to_i == @cart.id.to_i
      @ci.destroy
    end
    if request.xhr?
      respond_to do |format|
        format.js
      end
    else
      redirect_to cart_path
    end 
  end

  def checkout
    @title = 'Оформление заказа'
    @checkout = Checkout.new
    @cart = current_cart
    @delivery_methods = DeliveryMethod.all
    @payment_methods = PaymentMethod.all
  end

  def complete_checkout
    @cart = current_cart
    @checkout = Checkout.new(params[:checkout])
    if current_user
      @checkout.name, @checkout.email, @checkout.phone = current_user.name, current_user.email, current_user.phone
      @checkout.user_id = current_user.id
    end
    @cart.cart_items.each do |ci|
      @checkout.cart_items << ci
      ci.total = ci.quantity * ci.price
      ci.buy_price = ci.cartable.buy_price.to_s
    end
    @checkout.total = @checkout.cart_items.collect{|ci| ci.price * ci.quantity}.sum
    if @checkout.save
      @cart.cart_items.each do |ci|
        ci.update_attribute(:cart_id, nil)
      end
      CheckoutMailer.new_checkout(@checkout).deliver
      redirect_to '/thank_you'
    end
  end

  def thanks_for_checkout
    @title = 'Спасибо!'
  end

  def add_quantity
    @cart = current_cart
    @ci = CartItem.find(params[:id])
    @ci.update_attribute(:quantity, @ci.quantity + 1)
    if request.xhr?
      respond_to do |format|
        format.js
      end
    else
      redirect_to cart_path
    end
  end

  def remove_quantity
    @cart = current_cart
    @ci = CartItem.find(params[:id])
    @quantity = @ci.quantity - 1
    if @quantity >= 1 
      @ci.update_attribute(:quantity, @quantity)
    else
      if @ci.cart_id.to_i == @cart.id.to_i
        @ci.destroy
      end
    end
    if request.xhr?
      respond_to do |format|
        format.js
      end
    else
      redirect_to cart_path
    end    
  end

end
