class Api::V1::TransactionsController < ApplicationController
  before_action :require_login

  def index
    @transactions = Transaction.all
    render json: { status: 'success', data: @transactions }, status: :ok
  end

  def show
    @transaction = Transaction.find(params[:id])
    render json: { status: 'success', data: @transaction }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { status: 'error', message: 'Transaction not found.' }, status: :not_found
  end

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      render json: { status: 'success', data: @transaction }, status: :created
    else
      render json: { status: 'error', message: @transaction.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def update
    @transaction = Transaction.find(params[:id])
    if @transaction.update(transaction_params)
      render json: { status: 'success', data: @transaction }, status: :ok
    else
      render json: { status: 'error', message: @transaction.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { status: 'error', message: 'Transaction not found.' }, status: :not_found
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    render json: { status: 'success', message: 'Transaction deleted successfully.' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { status: 'error', message: 'Transaction not found.' }, status: :not_found
  end

  private

  def transaction_params
    params.require(:transaction).permit(:product_id, :quantity, :total_amount)
  end

  def require_login
    unless @current_user
      render json: { status: 'error', message: 'You must be logged in to access this resource.' }, status: :unauthorized
    end
  end
end
