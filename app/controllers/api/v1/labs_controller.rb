class API::V1::LabsController < ApplicationController
  before_action :set_lab, only: [:show, :update, :destroy]

  def index
    labs = Lab.all
    render json: {
      labs: labs,
      status: 200
    }
  end

  def create
    puts "params are #{params}"
    puts "lab_params are #{lab_params}"

    lab = Lab.new(lab_params)
    first_user = lab.users.build({name: lab_params[:name], admin: true})

    if lab.save
      # render json: { lab: lab, user: first_user, status: 200 }
      render json: {
        status: 'SUCCESS',
        message: 'Lab created!',
        data: { lab: lab, user: first_user, pin_codes: lab.invite_codes }
        },
        status: :ok
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

  def get_lab
    lab = Lab.find(params[:id])
  end

  def lab_params
      # params.require(:data).require(:attributes).permit(:name, :institute)
      params.require(:lab).permit(:name, :institute)
    end
end
