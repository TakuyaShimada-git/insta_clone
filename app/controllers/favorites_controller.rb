class FavoritesController < ApplicationController
  before_action :logged_in_user
  
  def create
    @micropost = Micropost.find(params[:micropost_id])
    @micropost.favo(current_user)
  end

  def destroy
    @micropost = Favorite.find(params[:id]).micropost
    @micropost.unfavo(current_user)
  end
end
