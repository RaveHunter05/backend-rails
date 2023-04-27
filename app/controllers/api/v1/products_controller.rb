class Api::V1::ProductsController < ApplicationController
  before_action :require_login

  def index
    @products = Product.all
    render json: @products
  end

  def show
    @product = Product.find(params[:id])
    render json: @product
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      render json: @product, status: :created
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      render json: @product
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    head :no_content
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :sku, :category, :manufacturer, :cost, :price, :quantity)
  end

  def require_login
    unless @current_user
      render json: { status: 'error', message: 'You must be logged in to access this resource.' }, status: :unauthorized
    end
  end
end
