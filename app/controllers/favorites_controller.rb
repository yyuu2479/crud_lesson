class FavoritesController < ApplicationController
  
  def create
    user = current_user
    comment = Comment.find(params[:comment_id])
    @favorite = Favorite.new(user_id: user.id, comment_id: comment.id)
    @favorite.save
    redirect_back fallback_location: root_path
  end

  def destroy
    user = current_user
    comment = Comment.find(params[:comment_id])
    Favorite.find_by(user_id: user.id, comment_id: comment.id).destroy
    redirect_back fallback_location: root_path
  end
  
end
