class FavoritesController < ApplicationController
  before_action :logged_in_user
  
  def create
    @micropost = Micropost.find(params[:micropost_id])
    @micropost.favo(current_user)
    respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
    end
  end

  def destroy
    @micropost = Favorite.find(params[:id]).micropost
    @micropost.unfavo(current_user)
    respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
    end
  end
end
