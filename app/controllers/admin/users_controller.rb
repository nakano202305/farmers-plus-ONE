class Admin::UsersController < ApplicationController
  
  def index
  end
  
  def show
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @farmers = Farmer.includes(:favorited_users).sort_by {|x|
                                                          x.favorited_users.includes(:favorites).where(created_at: from...to).size
                                                         }.reverse
  end  
  
end
