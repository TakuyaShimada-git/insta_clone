class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :micropost_id

      t.timestamps
      
      t.index :favorites, :user_id
      t.index :favorites, :micropost_id
      t.index :favorites, [:user_id, :micropost_id], unique: true
    end
  end
end
