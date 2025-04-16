class ContributionsController < ApplicationController
    before_action :set_contribution, only: [:show, :update, :destroy]
    include AuthorizeRequest
  
    # GET /contributions
    def index
      @contributions = Contribution.all
      render json: @contributions
    end
  
    # GET /contributions/:id
    def show
      render json: @contribution
    end
  
    # POST /contributions
    def create
      @contribution = Contribution.new(contribution_params)
  
      if @contribution.save
        render json: @contribution, status: :created
      else
        render json: @contribution.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /contributions/:id
    def update
      if @contribution.update(contribution_params)
        render json: @contribution
      else
        render json: @contribution.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /contributions/:id
    def destroy
      @contribution.destroy
      head :no_content
    end
  
    private
  
    def set_contribution
      @contribution = Contribution.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Contribution not found' }, status: :not_found
    end
  
    def contribution_params
      params.require(:contribution).permit(:user_id, :group_id, :amount, :date, :status)
    end
  end  