class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :name, uniqueness: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 100 }
  
  has_one_attached :profile_image
  
  has_many :farmers, dependent: destroy
  has_many :farmer_comments, dependent: destroy
  has_many :favorites, dependent: :destroy
  
  #to_groups
  has_many :groups
  #to_group_users
  has_many :group_users
  has_many :join_groups, through: :group_users, source: :group
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  def join_group(group)
    self.group_users.find_or_create_by(group_id: group.id)
  end
  
  def exit_group(group)
    group_user = self.group_users.find_by(group_id: group.id)
    group_user.destroy if group_user
  end
  
  def join_group?(group)
    self.join_groups.include?(group)
  end
  
end
