class Api::V1::SessionsController < ApplicationController
  respond_to :json

  def create
    user = User.find_for_database_authentication(email: params[:email])
    if user&.valid_password?(params[:password])
      render json: payload(user)
    else
      render json: { errors: ['Invalid Username/Password'] }, status: :unauthorized
    end
  end

  def show; end

  def destroy; end

  private

  def payload(user)
    return nil unless user
    {
      auth_token: JsonWebToken.encode({ user_id: user.id }),
      exp: TOKEN_EXPIRE_TIME,
      user: { id: user.id, email: user.email }
    }
  end
end
