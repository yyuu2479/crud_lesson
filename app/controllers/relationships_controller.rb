class RelationshipsController < ApplicationController
  def following
    @user = User.find(params[:user_id])
    @following = @user.following_user
  end
  
  def follower
    @user = User.find(params[:user_id])
    @follower = @user.follower_user
  end
  
  def create
    current_user.follow(params[:user_id])
    redirect_back fallback_location: root_path
  end
  
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_back fallback_location: root_path
  end
end
