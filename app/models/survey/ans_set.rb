class Survey::AnsSet < ActiveRecord::Base
  belongs_to :survey, class_name: "Survey::Info"
  belongs_to :user, class_name: "User"

  structure do
  end
end
