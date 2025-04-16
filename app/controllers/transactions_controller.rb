class TransactionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]
  before_action :set_transaction, only: [:show, :update, :destroy]
  include AuthorizeRequest

  def index
    @transactions = Transaction.all
    render json: @transactions
  end

  def show
    render json: @transaction
  end

  def create
    @transaction = Transaction.new(transaction_params)
    authorize_group_admin!(@transaction.group_id)

    if @transaction.save
      render json: @transaction, status: :created
    else
      render json: { errors: @transaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize_group_admin!(@transaction.group_id)

    if @transaction.update(transaction_params)
      render json: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize_group_admin!(@transaction.group_id)

    @transaction.destroy
    head :no_content
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Transaction not found" }, status: :not_found
  end

  def transaction_params
    params.require(:transaction).permit(:user_id, :group_id, :amount, :status)
  end

  def authorize_group_admin!(group_id)
    group = Group.find_by(id: group_id)
    unless group && @current_user.id == group.admin_id
      render json: { error: "Only group admin can perform this action" }, status: :unauthorized
    end
  end
end