class Article < ApplicationRecord
  validates :title, presence: true
  validates :introduction, presence: true
  validates :text,presence: true
  validate :check_image

  has_many :article_images, dependent: :destroy
  accepts_nested_attributes_for :article_images, allow_destroy: true
  has_many :categories
  belongs_to :group
  
  has_many :comments, dependent: :destroy
  belongs_to :profile

  def check_image
    if article_images.empty?
      errors.add(:article_images, "がありません")
    end
  end
  
end
