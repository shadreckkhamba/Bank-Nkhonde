class AuthenticationController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:login, :register]
  skip_before_action :authorize_request, only: [:login, :login_form, :register, :register_form]

  def login_form
    render :login_form
  end
  
    # POST /auth/login
  def login
    username = params.dig(:authentication, :username) || params[:username]
    password = params.dig(:authentication, :password) || params[:password]

    user = User.find_by(username: username)

    if user&.authenticate(password)
      token = encode_token({ user_id: user.id })

      respond_to do |format|
        format.json do
          render json: {
            token: token,
            message: "Login successful",
            user: {
              id: user.id,
              username: user.username
            }
          }, status: :ok
        end

        format.html do
          session[:user_id] = user.id
          flash[:notice] = "Logged in as: #{user.username}"
          redirect_to root_path
        end
      end
    else
      respond_to do |format|
        format.json do
          render json: { error: "Invalid username or password" }, status: :unauthorized
        end

        format.html do
          flash.now[:alert] = "Invalid username or password"
          render :login_form, status: :unauthorized
        end
      end
    end
  end


    # POST /auth/register
  def register
    username = params.dig(:authentication, :username) || params[:username]
    password = params.dig(:authentication, :password) || params[:password]
    password_confirmation = params.dig(:authentication, :password_confirmation) || params[:password_confirmation]
    phone = params.dig(:authentication, :phone) || params[:phone]
    
    # Check if user already exists
    if User.exists?(username: username)
      render json: { error: "Username already taken" }, status: :unprocessable_entity and return
    end

    # Create new user with required fields
    user = User.new(username: username, password: password, password_confirmation: password_confirmation, phone: phone)

    if user.save
      token = encode_token({ user_id: user.id })

      respond_to do |format|
        format.json do
          render json: {
            token: token,
            message: "Registration successful",
            user: {
              id: user.id,
              username: user.username
            }
          }, status: :created
        end

        format.html do
          session[:user_id] = user.id
          flash[:notice] = "Registered and logged in as: #{user.username}"
          redirect_to root_path
        end
      end
    else
      respond_to do |format|
        format.json do
          render json: { error: user.errors.full_messages }, status: :unprocessable_entity
        end

        format.html do
          flash.now[:alert] = "Registration failed: #{user.errors.full_messages.join(', ')}"
          render :register_form, status: :unprocessable_entity
        end
      end
    end
  end

  private

  def encode_token(payload)
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end