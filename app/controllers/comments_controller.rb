class CommentsController < ApplicationController
  def index
    @comments = Comment.all
    @comment = Comment.new
  end
  
  def show
    @comment = Comment.find(params[:id])
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def create
    @comment = Comment.new(comment_params)
    @comment.save
    redirect_to comments_path
  end
  
  def destroy
  end
  
  def update
    comment = Comment.find(params[:id])
    comment.update(comment_params)
    redirect_to comment_path(comment)
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:title, :body)
  end
  
end
