class Group < ApplicationRecord
  has_many :members
  has_many :profiles, through: :members
  has_many :articles
  validates :name,presence: true, length: { maximum: 20 }
  validates :text,presence: true, length: { maximum: 80 }
  
end
