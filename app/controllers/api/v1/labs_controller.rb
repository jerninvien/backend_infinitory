class API::V1::LabsController < ApplicationController
  before_action :set_lab, only: [:index, :show, :update, :destroy]
  skip_before_action :authenticate_user, only: :create

  def index
    labs = Lab.all
    render json: {
      labs: labs,
      status: 200
    }
  end

  def create
    lab = Lab.new(lab_params)
    first_user = lab.users.build({name: lab_params[:name], admin: true})

    if lab.save
      render json: {
        status: 200,
        message: 'Lab created!',
        data: {
          lab: lab,
          user: first_user,
          pin_codes: lab.invite_codes
        }},
        status: 200
    else
      render json: {
        errors: lab.errors,
        status: 500
      },
      status: 500
    end
  end

  def show

  end

  def update

  end

  def destroy

  end

  private

  def set_lab
    lab = Lab.find(params[:id])
  end

  def lab_params
      params.require(:lab).permit(:name, :institute)
    end
end
