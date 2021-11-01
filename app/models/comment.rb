class Comment < ApplicationRecord
  has_many :comment_images, dependent: :destroy
  accepts_nested_attributes_for :comment_images
  belongs_to :profile
  belongs_to :article
  validates :text,presence: true
end
