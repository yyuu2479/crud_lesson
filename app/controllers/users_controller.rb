class UsersController < ApplicationController
  before_action :authenticate_user!, only:[:show, :edit]
  before_action :ensure_correct_user, only:[:edit]

  def show
    @user = User.find(params[:id])
    
    @comments = @user.comments.page(params[:page]).per('4').reverse_order
    @favorites = @user.favorites.page(params[:page]).per('4').reverse_order

    @current_user_entry = Entry.where(user_id: current_user.id)
    @user_entry = Entry.where(user_id: @user.id)

    unless @user.id == current_user.id
      @current_user_entry.each do |cu|
        @user_entry.each do |u|
          if cu.room_id == u.room_id
            @is_room = true
            @room_id = cu.room_id
          end
        end
      end
      unless @is_room
        @room = Room.new
        @entry = Entry.new
      end
    end
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
