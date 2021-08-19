class PostCommentsController < ApplicationController
  
  def create
    comment = Comment.find(params[:comment_id])
    @post_comment = PostComment.new(post_comment_params)
    @post_comment.user_id = current_user.id
    @post_comment.comment_id = comment.id
    @post_comment.save
    redirect_back fallback_location: root_path
  end
  
  def destroy
    comment = Comment.find(params[:comment_id])
    PostComment.find_by(user_id: current_user.id, comment_id: comment.id).destroy
    redirect_back fallback_location: root_path
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:post_comment)
  end
end
