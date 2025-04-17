class ApplicationController < ActionController::Base
    include AuthorizeRequest
    protect_from_forgery with: :null_session

    helper_method :current_user
    def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
end
