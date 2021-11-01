class ArticlesController < ApplicationController
  before_action :authenticate_user!,only:[:index,:new, :create, :edit, :update, :destroy]
  before_action :get_article,only:[:show,:edit,:update]
  
  def index
    @articles=Article.all.page(params[:page]).per(9)
    
  end

  def new
    unless user_signed_in?
      redirect_to root_path
    end
    @article=Article.new
    @article.article_images.build
    @groups=Group.includes(:members).where(members: {profile_id: current_user.profile.id})
    @lat=params[:lat]
    @lng=params[:lng]
  end

  def create
    @article=Article.new(article_params)
    #update以外の関連付けは？
    @article.update(profile_id: current_user.profile.id)
    if @article.save
      redirect_to articles_url
    else
      render "new"
    end
  end

  def show
    @articles=@article.as_json(include: {article_images: {only: [:id,:picture]}})
    @comment=Comment.new
    @comment.comment_images.build
  end

  def edit
    unless current_user.profile.id == @article.profile_id
      redirect_to root_path
    end
    @groups=Group.includes(:members).where(members: {profile_id: current_user.profile.id})
  end

  def update
    if @article.update(article_params)
         redirect_to root_path
    else render "edit"
    end
  end

  def destroy
    @article=Article.find(params[:id]).destroy
  end

  def search
    @article = Article.where('title LIKE?', "%#{params[:title]}%").page(params[:page]).per(5)
  end

  private
    def article_params
      params.require(:article).permit(:title,:introduction,:text,:lat,:lng,:group_id,article_images_attributes: [:id,:_destroy,:picture,:introduction])
    end

    def get_article
     @article=Article.find(params[:id])
    end
    
end
