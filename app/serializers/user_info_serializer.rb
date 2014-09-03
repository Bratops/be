class UserInfoSerializer < ActiveModel::Serializer
  root false
  attributes :name, :role, :roles
  has_many :roles

  def name
    if object.user_info
      object.user_info.name
    else
      "~~~"
    end
  end

  def role
    "guest" || object.xrole.name
  end
end
