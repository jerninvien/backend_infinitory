class API::V1::WelcomeController < ApplicationController

  def index
    render json: { api_v1: 'hello worldz' }
  end
end
