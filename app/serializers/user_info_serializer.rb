class UserInfoSerializer < ActiveModel::Serializer
  root false
  attributes :name, :role, :roles
  has_many :roles

  def name
    object.user_info.name
  end

  def role
    "guest" || object.xrole.name
  end
end
