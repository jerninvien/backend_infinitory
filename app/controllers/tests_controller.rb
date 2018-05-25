class TestsController < ApplicationController

  def things
    render json: { hello: 'worldzs' }
  end
end
