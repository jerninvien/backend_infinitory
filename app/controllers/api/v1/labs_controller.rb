class API::V1::LabsController < ApplicationController
  before_action :set_lab, only: [:show, :update, :destroy]
  skip_before_action :authenticate_user, only: :create

  def index
    labs = Lab.all
    render json: { labs: labs }, status: 200
  end

  def create
    puts "params are #{params}"
    puts "lab_params #{lab_params}"

    lab = Lab.create(name: lab_params[:name])

    if lab
      puts "Saving new lab!"
      render json: {
          currentUser: lab.users.first,
          invite_codes: lab.invite_codes,
          lab: lab,
        },
        status: 200
    else
      # puts "errors 1 #{lab.errors.full_messages}"
      render json: { errors: lab.errors.full_messages }, status: 500
    end
  end

  def show
    puts "Show lab #{@lab}"
    render json: {
        devices: @lab.devices,
        invite_codes: @lab.invite_codes,
        lab: @lab,
        users: @lab.users.as_json(
          only: [:id, :admin, :name, :invited_by, :role, :updated_at]
        ),
      },
      status: 200
  end

  def update
  end

  def destroy
  end

  private

  def set_lab
    # ADD DEFAULT SCOPE WITH .includes([:user, :devices, :invite_codes])
    # ...HERE OR IN MODEL?
    @lab = Lab.includes(:devices, :invite_codes, users: [:devices, :invite_codes])
              .find(@current_user.lab_id)
  end

  def lab_params
      params.require(:lab).permit(:name, :institute)
    end
end
