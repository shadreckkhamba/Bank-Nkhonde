class UsersController < ApplicationController
  include AuthorizeRequest
  skip_before_action :authorize_request, only: [:create]
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :set_user, only: [:show, :update, :destroy]
  
  # POST /users
  def create
    join_code = params[:join_code]
    group = Group.find_by(join_code: join_code)
    
    unless group
      render json: { error: "Invalid join code" }, status: :unprocessable_entity
      return
    end
    
    @user = User.new(user_params)
    @user.group_id = group.id
    
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
      group = Group.find_by(join_code: params[:join_code])
      unless group
        render json: { error: "Invalid join code" }, status: :unprocessable_entity
        return
      end
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
    authorize_group_admin!
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    authorize_group_admin!
    if @user.destroy
      head :no_content
    else
      render json: { error: 'User could not be deleted' }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end

  def user_params
    permitted = [:name, :email, :phone, :gender, :role, :password, :password_confirmation, :group_id]
    params.require(:user).permit(permitted)
  end

  def authorize_group_admin!
    group = @user.group
    unless group && @current_user.id == group.admin_id
      render json: { error: 'Only group admin can perform this action' }, status: :unauthorized
    end
  end

end