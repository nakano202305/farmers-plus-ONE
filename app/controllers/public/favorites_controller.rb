class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @farmer = Farmer.find(params[:farmer_id])
    favorete = current_user.favorites.new(farmer_id: @farmer.id)
    favorite.save
    render :favorite
    #redirect_back(fallback_location: root_path)
  end
  
  def destroy
    @farmer = Farmer.find(params[:farmer_id])
    favorite = current_user.favorites.find_by(farmer_id: @farmer.id)
    favorite.destroy
    render :favorite
    #redirect_back(fallback_location: root_path)
  end
  
  
end