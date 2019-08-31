class AddFavoriteToMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :favorite, :integer
  end
end
