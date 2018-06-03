class API::V1::LabsController < ApplicationController

  def index
    render json: { api_v1: 'hello LabsController' }
  end

  def create
    lab = Lab.new(name: params[:name])
    first_user = lab.users.new
  end

  def show

  end

  def update

  end

  def destroy

  end

  private

  def lab_params
      params.require(:lab).permit(:name)
    end
end
