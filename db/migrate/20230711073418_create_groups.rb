class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.integer :user_id
      t.integer :farmer_id
      t.string :name
      t.text :introduction
      t.integer :prefecture, null: false, default: 0

      t.timestamps
    end
  end
end
