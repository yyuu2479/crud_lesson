class CommentsController < ApplicationController
  before_action :authenticate_user!, only:[:index, :show, :edit]
  before_action :ensure_correct_comment, only:[:edit, :destroy]

  def top
  end

  def index
    sort = params[:keyword]
    comments = Comment.sort_for(sort)
    @comments = Kaminari.paginate_array(comments).page(params[:page])
    @comment = Comment.new
  end

  def show
    @comment = Comment.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @comment.post_comments.page(params[:page]).per('4').reverse_order
  end

  def edit
    @comment = Comment.find(params[:id])
  end


  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = "投稿が完了しました！！！"
      redirect_to comments_path
    else
      @comments = Comment.page(params[:page]).reverse_order
      render :index
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to comments_path
  end

  def update
    comment = Comment.find(params[:id])
    comment.update(comment_params)
    redirect_to comment_path(comment)
  end



  private

  def comment_params
    params.require(:comment).permit(:title, :body, :image)
  end

  def ensure_correct_comment
    @Comment = Comment.find(params[:id])
    unless @Comment.user == current_user
      redirect_to comments_path
    end
  end

end
