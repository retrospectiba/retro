class HomeController < ApplicationController
  # GET /home
  # GET /home.json
  def index
    if session[:user_id]
      redirect_to retrospectives_path
    else
      render layout: false
    end
  end
end
