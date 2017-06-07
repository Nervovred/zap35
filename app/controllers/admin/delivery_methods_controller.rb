class Admin::DeliveryMethodsController < ApplicationController
  layout 'admin'

  def index
    @delivery_methods = DeliveryMethod.all
  end

  def new
    @delivery_method = DeliveryMethod.new
  end

  def create
    @delivery_method = DeliveryMethod.new(params[:delivery_method])
    if @delivery_method.save
      redirect_to admin_delivery_methods_path
    else
      render :action => 'new'
    end
  end

  def edit
    @delivery_method = DeliveryMethod.find(params[:id])
  end

  def update
    @delivery_method = DeliveryMethod.find(params[:id])
    if @delivery_method.update_attributes(params[:delivery_method])
      redirect_to admin_delivery_methods_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @delivery_method = DeliveryMethod.find(params[:id])
    @delivery_method.destroy
    redirect_to admin_delivery_methods_path
  end

  def show
    @delivery_method = DeliveryMethod.find(params[:id])
  end    
end
