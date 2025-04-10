class GroupsController < ApplicationController
    before_action :set_group, only: [:show]
  
    # GET /groups/:join_code
    def show
      render json: @group, include: [:users, :contributions, :transactions, :histories]
    end
  
    private
  
    def set_group
      @group = Group.find_by(join_code: params[:join_code])
      if @group.nil?
        render json: { error: 'Group not found' }, status: :not_found
      end
    end
  end  