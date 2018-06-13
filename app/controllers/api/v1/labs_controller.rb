class API::V1::LabsController < ApplicationController
  before_action :set_lab, only: [:show, :update, :destroy]
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
      puts "Saving new lab!"
      render json: {
          status: 200,
          lab: lab,
          pin_codes: lab.invite_codes,
          users: lab.users,
          devices: lab.devices
        },
        status: 200
    else
      render json: {
        error: lab.errors.messages,
        status: 500
      },
      status: 500
    end
  end

  def show
    render json: {
        status: 200,
        lab: lab,
        pin_codes: lab.invite_codes,
        users: lab.users,
        devices: lab.devices
      },
      status: 200
  end

  def update
    # THINK ABOUT LAB UPDATE PERMISSIONS
  end

  def destroy
    # THINK ABOUT LAB DELETE PERMISSIONS
  end

  private

  def set_lab
    # lab = Lab.find(params[:id])
    # ADD DEFAULT SCOPE WITH .includes([:user, devices, :invite_codes])
    # ...HERE OR IN MODEL?
    lab = @current_user.lab
  end

  def lab_params
      params.require(:lab).permit(:name, :institute)
    end
end
