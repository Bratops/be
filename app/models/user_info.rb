class UserInfo < ActiveRecord::Base
  structure do
    name ""
    phone ""
    gender 0
    password_outdated true

    timestamps
  end
end

