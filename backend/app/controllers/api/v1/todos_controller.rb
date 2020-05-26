class Api::V1::TodosController < ApplicationController
  before_action :authenticate_request!

  def index
    render json: { message: 'todo list' }
  end
end
