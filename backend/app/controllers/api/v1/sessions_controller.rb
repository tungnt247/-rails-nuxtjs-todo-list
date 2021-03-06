class Api::V1::SessionsController < ApplicationController
  before_action :authenticate_request!, only: %i[show]
  respond_to :json

  def create
    user = User.find_for_database_authentication(email: params[:email])
    if user&.valid_password?(params[:password])
      render json: payload(user)
    else
      render json: { errors: ['Invalid Username/Password'] }, status: :unauthorized
    end
  end

  def show
    render json: { email: current_user.email, id: current_user.id }
  end

  def facebook_login
    render json: FacebookAuthenService.new(params[:facebook_code]).call
  end

  private

  def payload(user)
    return nil unless user
    {
      token: JsonWebToken.encode({ user_id: user.id, exp: TOKEN_EXPIRE_TIME } )
    }
  end
end
