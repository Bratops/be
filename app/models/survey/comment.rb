class Survey::Comment < ActiveRecord::Base
  belongs_to :ans_choice, class_name: "Survey::AnsChoice"

  structure do
    content ""
  end
end
