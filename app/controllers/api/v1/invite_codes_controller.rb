class API::V1::InviteCodesController < ApplicationController

  def index
    render json: { invite_codes: @current_user.invite_codes }
  end

  def create
    if InviteCode.claim_invite_code(@current_user)
      render json: {
        invite_codes: @current_user.lab.invite_codes
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
