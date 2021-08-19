class FavoritesController < ApplicationController
  before_action :authenticate_user!, only:[:create, :destroy]
  
  def create
    comment = Comment.find(params[:comment_id])
    Favorite.create(user_id: current_user.id, comment_id: comment.id)
    redirect_back fallback_location: root_path
  end

  def destroy
    comment = Comment.find(params[:comment_id])
    Favorite.find_by(user_id: current_user.id, comment_id: comment.id).destroy
    redirect_back fallback_location: root_path
  end
  
end
