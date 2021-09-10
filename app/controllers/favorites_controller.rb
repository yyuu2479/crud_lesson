class FavoritesController < ApplicationController
  
  def create
    user = current_user
    @comment = Comment.find(params[:comment_id])
    @favorite = Favorite.create(user_id: user.id, comment_id: @comment.id)
    @comment.create_notification_like(current_user)
  end

  def destroy
    user = current_user
    @comment = Comment.find(params[:comment_id])
    Favorite.find_by(user_id: user.id, comment_id: @comment.id).destroy
  end
  
end
