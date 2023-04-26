class Api::V1::AuthenticationController < ApplicationController

  before_action :authenticate_user, except: :login

  def login
    @user = User.find_by(email: params[:email])
    puts(@user.inspect)
    if @user
      token = jwt_encode(user_id: @user.id)
      render json: {token: token}, status: :ok
    else
      render json: {error: 'unauthorized'}, status: :unauthorized
    end
  end
end
