class UsersController < ApplicationController
  before_action :ensure_correct_user, only:[:edit]

  def show
    @user = User.find(params[:id])
    @comments = @user.comments.page(params[:page]).per('2').reverse_order
    @favorites = @user.favorites
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_name_params)
      flash[:notice] = "更新が完了しました"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_name_params
    params.require(:user).permit(:name, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
