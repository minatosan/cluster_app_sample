class MainPagesController < ApplicationController

  def index

  end

  def new
    @articles=Article.all.includes(:article_images).as_json(include: {article_images: {only: :picture}})
    @groups=Group.includes(:members).where(members: {profile_id: current_user.profile.id})
  end
end
