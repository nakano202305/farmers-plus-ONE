class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @farmer = Farmer.find(params[:farmer_id])
    current_user.favorites.find_or_create_by(farmer_id: @farmer.id)
    render :favorite
  end
  
  def destroy
    @farmer = Farmer.find(params[:farmer_id])
    current_user.favorites.find_by(farmer_id: @farmer.id)&.destroy
    render :favorite
  end
end