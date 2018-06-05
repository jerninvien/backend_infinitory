class API::V1::LabsController < ApplicationController

  def index
    render json: { api_v1: 'hello LabsController' }
  end

  def create
    puts "params are #{params}"

    lab = Lab.new({name: params[:name]})
    first_user = lab.users.build({
      name: params[:name],
      admin: true
      })

    if lab.save
      render json: { lab: lab, user: first_user, status: 200 }
    else
      render json: { errors: lab.errors, status: 500 }
    end
  end

  def show

  end

  def update

  end

  def destroy

  end

  private

  def lab_params
      # params.require(:data).require(:attributes).permit(:name, :institute)
      params.require(:lab).permit(:name, :institute)
    end
end
