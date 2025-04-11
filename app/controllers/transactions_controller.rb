class TransactionsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]
    before_action :set_transaction, only: [:show, :update, :destroy]
  
    def index
      @transactions = Transaction.all
      render json: @transactions
    end
  
    def show
      render json: @transaction
    end
  
    def create
        transaction = Transaction.new(transaction_params)
      
        if transaction.save
          render json: transaction, status: :created
        else
          render json: { errors: transaction.errors.full_messages }, status: :unprocessable_entity
        end
    end
  
    def update
      if @transaction.update(transaction_params)
        render json: @transaction
      else
        render json: @transaction.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @transaction.destroy
      head :no_content
    end
  
    private
  
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end
  
    def transaction_params
      params.require(:transaction).permit(:user_id, :group_id, :amount, :status)
    end
  end  