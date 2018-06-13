class API::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  skip_before_action :authenticate_user, only: :create

  def index
    render json: {
      users: @current_user.lab.users,
      status: 200
    }
  end

  def create
    puts "params are #{params}"
    puts "user_params are #{user_params}"

    invite_code = InviteCode.find_by({
      code: user_params[:pin_code]
      })

    if invite_code
      puts "invite_code found: #{invite_code}"
      lab = invite_code.lab

      user = lab.users.build({
        name: user_params[:name],
        invited_by_user_id: invite_code.user_id
        })

      if user.save
        puts "Saving new user and removing InviteCode"
        invite_code.destroy

        render json: {
            status: 200,
            user: user,
            lab: lab
          },
          status: 200
      else
        render json: {
          error: user.errors.messages,
          status: 500
        },
        status: 500
      end
    else
      puts "invalid pin code!"
      render json: {
        status: 403,
        error: 'Invalid pin code'
      },
      status: 403
    end
  end

  def show
    render json: {
      status: 200,
      data: {
        bookings: user.bookings,
        devices: user.devices,
        invited_by: user.invited_by,
        user: user
      }},
      status: 200
  end

  def update

  end

  def destroy

  end

  private

  def set_user
    user = User.find(params[:id]) || @current_user
    # user = User.find(params[:id]) if params[:id] else @current_user
  end

  def user_params
      params.require(:user).permit(:name, :pin_code)
    end
end
