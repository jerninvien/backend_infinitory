class API::V1::InviteCodesController < ApplicationController

  def index
    render json: {
      invite_codes: @current_user.lab.invite_codes
    }
  end

  def create
    if @current_user.generate_pin_code
      render json: {
        invite_code: @current_user.invite_codes.last,
        status: 200
      },
      status: 200
    else
      render json: {
        user: @current_user.errors.messages
      },
      status: 403
    end
  end
end
