class API::V1::InviteCodesController < ApplicationController

  def index
    render json: {
      invite_codes: @current_user.invite_codes
    }
  end

  def create
    if @current_user.generate_invite_code
      render json: {
        data: {
          invite_codes: @current_user.lab.invite_codes
        },
        status: 200
      },
      status: 200
    else
      render json: {
        error: @current_user.errors.messages,
        invite_codes: @current_user.lab.invite_codes
      },
      status: 403
    end
  end
end
