class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @farmer = Farmer.new
    @groups = Group.all

  end

  def show
    @farmer = Farmer.new
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user_id = current_user.id

    if @group.save!
      redirect_to groups_path
    else
      render "new"
    end
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

  def destroy
    @group =Group.find(params[:id])
    @group.destroy
    redirect_to groups_path
  end

  def new_mail
    @group = Group.find(params[:group_id])
  end

  def send_mail
    @group = Group.find(params[:group_id])
    group_users = @group.users
    @mail_title = params[:mail_title]
    @mail_content = params[:mail_content]
    ContactMailer.send_mail(@mail_title, @mail_content,group_users,@group).deliver
  end




  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image, :prefecture, :farmer_id )
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.user_id == current_user.id
      redirect_to groups_path
    end
  end

end
