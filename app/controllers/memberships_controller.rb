class MembershipsController < ApplicationController
    def create
        @group = Group.find(params[:group_id])
        @membership = @group.memberships.new(membership_params)
      
        if @membership.save
          render json: @membership, status: :created
        else
          render json: { errors: @membership.errors.full_messages }, status: :unprocessable_entity
        end
    end
    
    def destroy
      membership = Membership.find(params[:id])
      membership.destroy
      render json: { message: 'Membership removed' }
    end
  
    private
  
    def membership_params
      params.require(:membership).permit(:user_id, :group_id, :status)
    end
  end  