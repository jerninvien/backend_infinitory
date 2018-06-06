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

    invite_code = InviteCode.find_by(
      {code: user_params[:pin_code]}
    )

    puts "current_user iss #{@current_user}"



    if invite_code
      lab = invite_code.lab

      user = lab.users.build({
        name: user_params[:name],
        invited_by_user_id: invite_code.user_id
        })

      if user.save
        invite_code.destroy

        render json: {
          status: 200,
          message: 'User created!',
          data: {
            user: user
          }},
          status: 200
      else
        render json: {
          errors: user.errors,
          status: 500
        },
        status: 500
      end
    else
      render json: {
        status: 403,
        message: 'Invalid pin code'
      },
      status: 403
    end
  end

  def show

  end

  def update

  end

  def destroy

  end

  private

  def get_user
    user = User.find(params[:id])
  end

  def user_params
      params.require(:user).permit(:name, :pin_code)
    end
end
