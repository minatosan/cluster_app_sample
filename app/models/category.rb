class Category < ApplicationRecord
  belongs_to :group
  belongs_to :article
  
end
