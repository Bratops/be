class Acn::UsersRole < ActiveRecord::Base
  self.table_name = "users_acn_roles"

  belongs_to :user
  belongs_to :role, class_name: "Acn::Role"
  structure do
  end
end
