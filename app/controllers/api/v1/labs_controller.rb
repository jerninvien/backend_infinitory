class API::V1::LabsController < ApplicationController

  def index
    render json: { api_v1: 'hello LabsController' }
  end

  def create
    lab = Lab.build(name: params[:name])
    first_user = lab.users.build(name: params[:name])

    if lab.save
      puts "it saved!"
      puts lab
      puts first_user
      render json: lab
    else
      puts "it did not save "
      puts lab
      puts first_user
      puts
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
