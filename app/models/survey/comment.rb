class Survey::Comment < ActiveRecord::Base
  belongs_to :ans, class_name: "Survey::Ans"

  structure do
    content ""
  end
end
