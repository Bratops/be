class UserSerializer < ActiveModel::Serializer
  #embed :ids, include: true

  root false
  attributes :auth_token, :login_alias, :name

  has_one :xrole, key: :role, serializer: RoleSerializer
  has_many :roles, each_serializer: RoleSerializer

  def auth_token
    object.authentication_token
  end

  def name
    "New Beaver" || object.user_info.name
  end
end
