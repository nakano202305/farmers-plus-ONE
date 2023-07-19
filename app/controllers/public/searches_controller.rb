class Public::SearchesController < ApplicationController

  def search
    if params[:search]
      if params[:key] == 'users'
        @users = User.search(params[:search])
      elsif params[:key] == 'farmers'
        @farmers = Farmer.search(params[:search])
      end
    end
    @key = params[:key]
  end

end
