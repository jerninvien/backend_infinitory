class API::V1::WelcomeController < ApplicationController
  skip_before_action :authenticate_user, only: :index

  def index
    user = Lab.last.users.first

    render json: {
      hello: 'world',
      user: Lab.last.users.first,
      lab: user.lab,      
    },
    status: 200
  end
end
