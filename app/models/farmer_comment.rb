class FarmerComment < ApplicationRecord
  
  belongs_to :user
  belongs_to :farmer
  
  validates :comment, presence: true
  
end
