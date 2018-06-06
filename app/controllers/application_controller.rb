class ApplicationController < ActionController::API
  before_action :authenticate_user

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response



  private
    def render_unprocessable_entity_response(exception)
      render json: exception.record.errors, status: :unprocessable_entity
    end

    def render_not_found_response(exception)
      render json: {
        error: exception.message
        },
        status: :not_found
    end


    def authenticate_user
      puts "authenticate_user"
      api_key = request.headers['X-USER-TOKEN']
      if api_key
        @current_user = User.find_by({api_key: api_key})
        #Unauthorize if a user object is not returned
        if @current_user.nil?
          return unauthorize
        end
      else
        return unauthorize
      end
    end

    def unauthorize
      puts "unauthorize"
      render json: {
        api_key: nil,
        status: 403
      },
        status: 403
      return false
    end
end
