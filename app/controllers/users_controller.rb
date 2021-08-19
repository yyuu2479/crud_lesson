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
    @user.update(user_name_params)
    redirect_to user_path(@user)
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
