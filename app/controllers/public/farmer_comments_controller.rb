class Public::FarmerCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:destroy]

  def create
    farmer = Farmer.find(params[:farmer_id])
    comment = current_user.farmer_comments.new(farmer_comment_params)
    comment.farmer_id = farmer.id
    comment.save
    @farmers = Farmer.find(params[:farmer_id])
    @farmer_comment = FarmerComment.new
    #redirect_back(fallback_location: root_path)
  end

  def destroy
    @farmer = Farmer.find(params[:farmer_id])
    @farmer_comment = FarmerComment.find_by(id: params[:id], farmer_id: params[:farmer_id])
    @farmer_comment.destroy
    #redirect_back(fallback_location: root_path)
  end


  private

  def farmer_comment_params
    params.require(:farmer_comment).permit(:comment)
  end

  def ensure_correct_user
    @farmer_comment = FarmerComment.find_by(id: params[:id], farmer_id: params[:farmer_id])
    if @farmer_comment.user != current_user
      redirect_to root_path
    end
  end

end
