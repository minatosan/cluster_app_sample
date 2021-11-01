class GroupsController < ApplicationController
  before_action :authenticate_user!,only:[:index,:new, :create, :edit, :update, :destroy]
  before_action :get_group,only:[:show,:edit,:update,:destroy]
  def index
    @groups=Group.all.page(params[:page]).per(5)
  end

  def new
    @group=Group.new
    #@members=Friend.where(from_user_id: current_user.profile.id,request: true)
    #@member=User.includes([:profile]).where(id: @members[0].to_user_id)
  end

  def create
    @group=Group.new(group_params)
    @group.update(admin_user_id: current_user.profile.id )
    if @group.save
      redirect_to root_path
    else
      render "new"
    end
  end

  def show
    @member=@group.members.find_by(profile_id: current_user.profile)
    @articles=Article.includes([:article_images,:profile]).where(group_id: @group).as_json(include: {article_images: {only: [:id,:picture]}})

  end

  def edit
    unless current_user.profile.id == @group.admin_user_id
       redirect_to root_path
    end
  end

  def update
    @group.update(group_params)
  end

  def destroy
    
  end

  def search
    @group = Group.where('name LIKE?', "%#{params[:name]}%").page(params[:page]).per(5)
    
    
  end

  def register
    @group=Group.find(params[:id])
    if current_user.profile.friend?(@group.admin_user_id)  
      @member=@group.members.build
      @member.update(profile_id: current_user.profile.id)
    else 
      redirect_to root_path
    end
  end

  private

    def group_params
      params.require(:group).permit(:name,:text,{:profile_ids => []})
    end

    def get_group
      @group=Group.find(params[:id])
    end
end
