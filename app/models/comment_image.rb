class CommentImage < ApplicationRecord
  belongs_to :comment, optional: true
  mount_uploader :picture, PictureUploader
  
end
