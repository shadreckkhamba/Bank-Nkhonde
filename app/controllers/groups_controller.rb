class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :update, :destroy]
  skip_before_action :verify_authenticity_token
  include AuthorizeRequest

  def create
    @group = Group.new(group_params)
    @group.admin_id = @current_user.id # Set current user as admin
    @group.join_code = SecureRandom.hex(4) # Auto-generated join code

    if @group.save
      render json: @group, status: :created
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  def index
    @groups = Group.all
    render json: @groups
  end

  def show
    render json: @group
  end

  def update
    authorize_admin!
    if @group.update(group_params)
      render json: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize_admin!
    @group.destroy
    head :no_content
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description, :contribution_amount, :total_amount)
  end

  def authorize_admin!
    unless @current_user.id == @group.admin_id
      render json: { error: 'Only the group admin can perform this action' }, status: :unauthorized
    end
  end
end