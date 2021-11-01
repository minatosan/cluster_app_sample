class FriendsController < ApplicationController
  before_action :get_profile 
  protect_from_forgery :except => [:update]

  def create
    @profile=Profile.find(params[:friend][:to_user_id])
    @user.follow(@profile)
  end

  def update
    @friend=Friend.find(params[:id])
    @friends=Friend.new(from_user_id: current_user.profile.id,to_user_id: @friend.from_user_id,request: true)
    @friend.update(friend_params)
    @friends.save
  end

  def destroy
    @friend=Friend.find(params[:id])
    @friends=Friend.find_by(to_user_id: current_user.profile.id,from_user_id: @friend.to_user_id)
    @friend.destroy
    @friends.destroy
  end

  private

  def get_profile
    @user=current_user.profile
  end

  def friend_params
    params.require(:friend).permit(:request)
  end
end
