class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  
  def index
    @farmer = Farmer.new
    @groups = Group.all
  end
  
  def sohw
    @farmer = Farmer.new
    @group = Group.find(params[:id])
  end
  
  def new
    @group = Group.new
  end
  
  def create
    @group = current_user.group.build(group_params)
    if @group.save
      redirect_to group_path
    else
      render "new"
  end
  
  def edit
  end
  
  def update
    @group =Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path
    else
      render "edit"
    end
  end
  
  
  private
  
  def group_params
    params.require(:group).permit(:name, :introduction, :imege, :prefecture, :farmer_id, :is_positioning)
  end
  
  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.user_id == current_user.id
      redirect_to groups_path
    end
  end

end
