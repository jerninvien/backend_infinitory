class WelcomeController < ApplicationController

  def index
    render json: {
      hello: 'world',
      user: Lab.last.users.first,
      lab: user.lab
    },
    status: 200
  end
end
