class Friend < ApplicationRecord
  belongs_to :from_user, class_name: "Profile"
  belongs_to :to_user, class_name: "Profile"
end
