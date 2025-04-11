class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:create]

  # POST /users
  def create
    join_code = params[:join_code]
    group = Group.find_by(join_code: join_code)
    
    unless group
      render json: { error: "Invalid join code" }, status: :unprocessable_entity
      return
    end
    
    @user = User.new(user_params)
    @user.group_id = group.id # Ensure the group_id is set here
    
    if @user.save
      render json: @user, status: :created, location: @user
    else
      Rails.logger.error "User creation failed: #{@user.errors.full_messages}"
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /users
  def index
    if params[:join_code]
      # Only if join_code is provided, filter by group
      group = Group.find_by(join_code: params[:join_code])
      
      unless group
        render json: { error: "Invalid join code" }, status: :unprocessable_entity
        return
      end

      # Fetch users for the specified group
      @users = group.users
    else
      @users = User.all
    end

    render json: @users
  end

  # GET /users/:id
  def show
    render json: @user
  end

  # PUT /users/:id
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    if @user.destroy
      head :no_content
    else
      render json: { error: 'User could not be deleted' }, status: :unprocessable_entity
    end
  end

  private

  # Set the user by ID
  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end

  # Strong parameters for user creation and updates
  def user_params
    permitted = [:name, :email, :phone, :gender, :role, :password, :password_confirmation, :group_id]
  
    if request.patch?
      params.require(:user).permit(permitted)
    else
      params.require(:user).permit(permitted)
    end
  end
end