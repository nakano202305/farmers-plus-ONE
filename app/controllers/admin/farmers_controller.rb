class Admin::FarmersController < ApplicationController
  before_action :authenticate_admin!

  def index
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @farmers = Farmer.includes(:favorited_users).sort_by {|x|
                                                          x.favorited_users.includes(:favorites).where(created_at: from...to).size
                                                         }.reverse
  end

  def show
    @farmer = Farmer.find(params[:id])
  end

  def destroy
    @farmer = Farmer.find(params[:id])
    @farmer.destroy
    redirect_to admin_path
  end

end
