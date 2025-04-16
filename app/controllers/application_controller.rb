class ApplicationController < ActionController::Base
    include AuthorizeRequest
    protect_from_forgery with: :null_session
end
