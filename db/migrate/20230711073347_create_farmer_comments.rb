class CreateFarmerComments < ActiveRecord::Migration[6.1]
  def change
    create_table :farmer_comments do |t|
      t.integer :user_id
      t.integer :farmer_id
      t.text :comment
      
      t.timestamps
    end
  end
end
