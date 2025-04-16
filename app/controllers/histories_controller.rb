class HistoriesController < ApplicationController
  before_action :set_history, only: [:show, :destroy]
  skip_before_action :verify_authenticity_token, only: [:create]
  include AuthorizeRequest

  def index
    @histories = History.all
    if @histories.empty?
      render json: { message: 'No histories found' }, status: :ok
    else
      render json: @histories
    end
  end

  def create
    @history = History.new(history_params)
    authorize_group_admin!(@history.group_id)

    if @history.save
      render json: @history, status: :created
    else
      render json: { errors: @history.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @history
  rescue ActiveRecord::RecordNotFound
    render json: { error: "History not found" }, status: :not_found
  end

  def destroy
    authorize_group_admin!(@history.group_id)

    if @history.destroy
      render json: { message: "History deleted successfully" }, status: :ok
    else
      render json: { errors: @history.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "History not found" }, status: :not_found
  end

  private

  def set_history
    @history = History.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "History not found" }, status: :not_found
  end

  def history_params
    params.require(:history).permit(:user_id, :group_id, :action, :timestamp)
  end

  def authorize_group_admin!(group_id)
    group = Group.find_by(id: group_id)
    unless group && @current_user.id == group.admin_id
      render json: { error: "Only group admin can perform this action" }, status: :unauthorized
    end
  end
end