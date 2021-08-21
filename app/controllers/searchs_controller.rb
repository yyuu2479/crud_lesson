class SearchsController < ApplicationController
  
  def index
    @content = params[:content]
    @model = params[:model]
    @method = params[:method]
    
    if @model == 'user'
      @user_record = User.search_for(@content, @method)
    else
      @comment_record = Comment.search_for(@content, @method)
    end
  end
end
