class UserInfo < ActiveRecord::Base
  belongs_to :user, touch: true
  structure do
    name ""
    phone ""
    gender 0

    timestamps
  end
end

