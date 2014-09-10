class UserSerializer < ActiveModel::Serializer
  #embed :ids, include: true

  root false
  attributes :auth_token, :login_alias, :name, :require_info

  has_one :xrole, key: :role, serializer: RoleSerializer
  has_many :roles, each_serializer: RoleSerializer

  def roles
    object.roles.where(resource_type: nil, resource_id: nil)
  end

  def auth_token
    object.authentication_token
  end

  def name
    if object.user_info
      object.user_info.name
    else
      "New Beaver"
    end
  end

  def require_info
    object.user_info && object.user_info.required
  end
end
