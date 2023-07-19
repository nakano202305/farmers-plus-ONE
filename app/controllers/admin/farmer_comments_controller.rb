class Admin::FarmerCommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @farmer = Farmer.find(params[:farmer_id])
    @farmer_comment = FarmerComment.find_by(id: params[:id], farmer_id: params[:farmer_id])
    @farmer_comment.destroy
    redirect_back(fallback_location: admin_path)
  end
end
