class Public::GroupUsersController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @group = Group.find(params[:group_id])
    current_user.join_group(@group)
    redirect_back(fallback_location: root_url)
  end
  
  def destroy
    @group = Group.find(params[:group_id])
    current_user.exit_group(@group)
    redirect_back(fallback_location: root_url)
  end
  
  def edit
    @group = Group.find(params[:group_id])
  end
  
  def update
    @group = Group.find(params[:group_id])
    if @group.update(group_params)
      redirect_to group_path
    else
      render "edit"
    end
  end
  
  
  private
  
  def group_user_params
    params.require(:group_user).permit(:farmer_id)
  end
  
  def ensure_correct_user
  
  end
  
end
