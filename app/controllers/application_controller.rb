class ApplicationController < ActionController::API
  before_action :authenticate_user

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  private
    def render_unprocessable_entity_response(exception)
      puts "render_unprocessable_entity_response #{exception}"
      render json: {
        error: exception.record.errors
        },
        status: :unprocessable_entity
    end

    def render_not_found_response(exception)
      puts "render_not_found_response #{exception}"
      render json: {
        error: exception.message
        },
        status: :not_found
    end


    def authenticate_user
      sleep 1
      puts "\n\n authenticate_user: #{request.headers}"

      puts "request.headers['X-USER-TOKEN']: #{request.headers['X-USER-TOKEN']}"

      # ENCRYPT / DECRYPTED ON-THE-FLY?
      api_key = request.headers['X-USER-TOKEN']

      puts "api_key: #{api_key}"
      if api_key
        @current_user = User.find_by({api_key: api_key})
        puts "show current_user #{@current_user}"

        #Unauthorize if a user object is not returned
        if @current_user.nil?
          return unauthorized
        end
      else
        return unauthorized
      end
    end

    def unauthorized
      puts "unauthorized user"
      render json: {
        api_key: nil,
        status: 403
      },
        status: 403
      return false
    end
end
