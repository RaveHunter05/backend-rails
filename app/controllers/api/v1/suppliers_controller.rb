class Api::V1::SuppliersController < ApplicationController
  before_action :require_login

  def index
    @suppliers = Supplier.all
    render json: @suppliers
  end

  def show
    @supplier = Supplier.find(params[:id])
    render json: @supplier
  end

  def create
    @supplier = Supplier.new(supplier_params)
    if @supplier.save
      render json: @supplier, status: :created
    else
      render json: { errors: @supplier.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @supplier = Supplier.find(params[:id])
    if @supplier.update(supplier_params)
      render json: @supplier
    else
      render json: { errors: supplier.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @supplier = Supplier.find(params[:id])
    @supplier.destroy
    head :no_content
  end

  private

  def supplier_params
    params.require(:supplier).permit(:name, :email, :phone)
  end

  def require_login
    unless session[:user_id]
      render json: { status: 'error', message: 'You must be logged in to access this resource.' }, status: :unauthorized
    end
  end
end
