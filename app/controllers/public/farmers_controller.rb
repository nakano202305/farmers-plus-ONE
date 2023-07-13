class Public::FarmersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def create
    @farmer = Farmer.new(farmer_params)
    @farmer.user_id = current_user.id
    if @farmer.save
      redirect_to farmer_path(@farmer),notice: "You have created farmer successfully."
    else
      @farmers = Farmer.all
      render 'index'
    end
  end

  def index
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @farmers = Farmer.includes(:favorited_users).sort_by {|x|
                                                          x.favorited_users.includes(:favorites).where(created_at: from...to).size
                                                         }.reverse
    @farmer = Farmer.new
  end

  def show
    @farmer = Farmer.find(params[:id])
    @user = @farmer.user
    @new = Farmer.new
    @farmer_comment = FarmerComment.new
  end

  def edit
    @farmer = Farmer.find(params[:id])
  end

  def update
    @farmer = Farmer.find(params[:id])
    if @farmer.update(farmer_params)
      redirect_to farmer_path(@farmer), notice: "You have updated farmer successfully."
    else
      render "edit"
    end
  end

  def delete
    @farmer = Farmer.find(params[:id])
    @farmer.destroy
    redirect_to farmers_path
  end


  private

  def farmer_params
    params.require(:farmer).permit(:title, :body)
  end

  def ensure_correct_user
    @farmer = Farmer.find(params[:id])
    unless @farmer.user == current_user
      redirect_to farmers_path
    end
  end

end
