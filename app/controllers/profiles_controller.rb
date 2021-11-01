class ProfilesController < ApplicationController
  before_action :get_profile,only:[:show,:destroy,:edit,:update] 
  before_action :authenticate_user!,only:[:index,:new, :create, :edit, :update, :destroy]
  before_action :current_profile,only:[:group,:article,:mypage]
  
  def index
    @profiles=Profile.where('nickname LIKE(?)', "%#{params[:keyword]}%").where.not(id: current_user.profile.id)
      respond_to do |format|
        format.html
        format.json
      end
    
  end

  def new
    if current_user.profile.nil?
      @profile=Profile.new
    else
      redirect_to root_path
    end
  end

  def create
    if @profile=Profile.new(profile_params)
    #update以外のやり方もないのか検証をする
      @profile.update(user_id: current_user.id)
      @profile.save
    else
      render "new"
    end
  end

  def show
    @articles=Article.includes([:article_images,:profile]).where(profile_id: @profile).as_json(include: {article_images: {only: [:id,:picture]}})
    @groups=Group.includes(:members).where(members: {profile_id: current_user.profile.id})
    @friend=current_user.profile.follower_friends.build
  end

  def edit
    unless current_user.id == @profile.user_id
      redirect_to root_path
    end
  end

  def update
    @profile.update(profile_params)
    redirect_to root_path
  end

  def destroy
    
  end

  def friend
    @follow_friends =Friend.where(from_user_id: current_user.profile.id,request: true)
    @profile=current_user.profile.follow_friends
    @friends=Friend.where(to_user_id: current_user.profile.id,request: false)
  end

  def mypage
    @first_article=@profile.articles.first
    @comments=@profile.comments
    @articles=Article.includes([:article_images,:profile]).where(profile_id: @profile).as_json(include: {article_images: {only: [:id,:picture]}})
    @groups=Group.includes(:members).where(members: {profile_id: current_user.profile.id})
  end

  def group
    @groups=@profile.groups
    @group=Group.page(params[:page]).per(5)
  end

  def article
    @article=@profile.articles
    @article=Article.page(params[:page]).per(6)
  end

  def search
    @profile = Profile.where('nickname LIKE?', "%#{params[:nickname]}%").where.not(id: current_user.profile.id).page(params[:page]).per(5)
    @friend=current_user.profile.follower_friends.build
  end

  def friend_request
    @friends=Friend.where(to_user_id: current_user.profile.id,request: false)
  end

  private
    def profile_params
      params.require(:profile).permit(:nickname,:avatar,:text)
    end

    def get_profile
      @profile=Profile.find(params[:id])
    end

    def current_profile
      @profile=current_user.profile
    end
end
