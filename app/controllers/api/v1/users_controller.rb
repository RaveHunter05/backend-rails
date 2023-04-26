class Api::V1::UsersController < ApplicationController

  skip_before_action :authenticate_user, only: [:create]
  
  before_action :find_user, only: [:show]

  def new
    @user = User.new
  end

  def show
    render json: @user, status: 200
  end

  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(create_user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private
  def create_user_params
    params.require(:user).permit(:name, :email, :password_digest)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
