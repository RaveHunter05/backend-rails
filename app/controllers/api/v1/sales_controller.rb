class Api::V1::SalesController < ApplicationController
  before_action :require_login

  def index
    @sales = Sale.all
    render json: @sales
  end

  def show
    @sale = Sale.find(params[:id])
    render json: @sale
  end

  def create
    @sale = Sale.new(sale_params)
    if @sale.save
      render json: @sale, status: :created
    else
      render json: { errors: @sale.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @sale = Sale.find(params[:id])
    if @sale.update(sale_params)
      render json: @sale
    else
      render json: { errors: @sale.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @sale = Sale.find(params[:id])
    @sale.destroy
    head :no_content
  end

  private

  def sale_params
    params.require(:sale).permit(:product_id, :quantity, :price, :total_price, :customer_name, :customer_email)
  end

  def require_login
    unless @current_user
      render json: { status: 'error', message: 'You must be logged in to access this resource.' }, status: :unauthorized
    end
  end
end
