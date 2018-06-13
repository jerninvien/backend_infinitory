class API::V1::WelcomeController < ApplicationController
  skip_before_action :authenticate_user, only: :index

  def index
    render json: { api_v1: 'hello worldz' }
  end
end
