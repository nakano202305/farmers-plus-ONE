class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.integer :user_id
      t.integer :farmer_id
      t.string :name
      t.text :introduction
      t.string :prefecture
      t.boolean :is_positioning, default: false
      
      t.timestamps
    end
  end
end
