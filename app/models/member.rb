class Member < ApplicationRecord
  belongs_to :profile
  belongs_to :group
  
end
