class Favorite < ApplicationRecord
  
  belongs_to :user
  belongs_to :group
  belongs_to :farmer
  
end
