class Admin::PaymentMethodsController < ApplicationController
  layout 'admin'

  def index
    @payment_methods = PaymentMethod.all
  end

  def new
    @payment_method = PaymentMethod.new
  end

  def create
    @payment_method = PaymentMethod.new(params[:payment_method])
    if @payment_method.save
      redirect_to admin_payment_methods_path
    else
      render :action => 'new'
    end
  end

  def edit
    @payment_method = PaymentMethod.find(params[:id])
  end

  def update
    @payment_method = PaymentMethod.find(params[:id])
    if @payment_method.update_attributes(params[:payment_method])
      redirect_to admin_payment_methods_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @payment_method = PaymentMethod.find(params[:id])
    @payment_method.destroy
    redirect_to admin_payment_methods_path
  end

  def show
    @payment_method = PaymentMethod.find(params[:id])
  end  
end
