class HomeController < ApplicationController
  skip_before_action :authorize_request, only: [:index]
  before_action :verify_authenticity_token  
  def index
    @user = User.find(session[:user_id]) if session[:user_id]
  end 
end
