class UserSerializer < ActiveModel::Serializer
  root false
  attributes :auth_token, :login_alias

  def auth_token
    object.authentication_token
  end
end
