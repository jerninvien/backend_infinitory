class API::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  skip_before_action :authenticate_user, only: :create

  def index
    render json: { users: @current_user.lab.users }, status: 200
  end

  def create
    puts "user_params are #{user_params}"
    invite_code = InviteCode.find_by(code: user_params[:invite_code])

    if invite_code && invite_code.user && invite_code.user.lab
      puts "invite_code found: #{invite_code}"

      current_user = User.new({
        invited_by: invite_code.user.name,
        lab: invite_code.user.lab,
        name: user_params[:name],
        })

      if current_user.save
        invite_code.reset_info

        render json: {
          currentUser: current_user,
          devices: current_user.lab.devices,
          invite_codes: current_user.lab.invite_codes,
          lab: current_user.lab,
          users: current_user.lab.users.as_json(
            only: [:id, :admin, :name, :invited_by, :role, :updated_at]
          ),
          }, status: 200
      else
        render json: { errors: current_user.errors }, status: 500
      end
    else
      render json: { errors: 'Invalid pin code' }, status: 403
    end
  end

  def show
    render json: {
        bookings: user.bookings,
        currentUser: @current_user,
        devices: user.devices,
        invited_by: user.invited_by,
        user: user,
      },
      status: 200
  end

  def update
  end

  def destroy
  end

  private

  def set_user
    user = User.find(params[:id]) || @current_user
  end

  def user_params
      params.require(:users).permit(:name, :invite_code)
    end
end
