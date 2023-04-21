class Api::V1::SessionsController < ApplicationController
  def create
    @user = User.find_by(name: params[:name])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      render json: { status: 'success', message: 'Logged in successfully.' }
    else
      render json: { status: 'error', message: 'Invalid username or password.' }, status: :unauthorized
    end
  end

  def new
  end

  def destroy
    session.delete(:user_id)
    render json: { status: 'success', message: 'Logged out successfully.' }
  end
end
