class CommentsController < ApplicationController
  before_action :authenticate_user!,only:[:create, :edit, :update, :destroy]
  def create
    @comment=Comment.new(comment_params)
    @comment.update(profile_id: current_user.profile.id)
    @comment.save
  end

  def edit
  end

  def update
  end

  def destroy
    @comment=Comment.find(params[:id]).destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:text,:article_id,comment_images_attributes: [:picture])
  end
end
