class PostCommentsController < ApplicationController

  def create
    @comment = Comment.find(params[:comment_id])
    @post_comment = PostComment.new(post_comment_params)
    @post_comment.user_id = current_user.id
    @post_comment.comment_id = @comment.id
    @comment_notification = @post_comment.comment
    @post_comment.save
    
    @comment_notification = @post_comment.comment
    @comment_notification.create_notification_comment(current_user, @post_comment.id)
    
    @post_comments = @comment.post_comments.page(params[:page]).per('4').reverse_order
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    PostComment.find_by(user_id: current_user.id, comment_id: @comment.id).destroy

    @post_comments = @comment.post_comments.page(params[:page]).per('4').reverse_order
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:post_comment)
  end
end
