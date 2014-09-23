class UserSerializer < ActiveModel::Serializer
  #embed :ids, include: true
  root false
  attributes :auth_token, :login_alias, :name, :require_info, :school

  has_one :xrole, key: :role, serializer: RoleSerializer
  has_many :roles, each_serializer: RoleSerializer

  def roles
    object.roles.where(resource_type: nil, resource_id: nil).
      where("name != 'teacher_applicant'")
  end

  def auth_token
    object.authentication_token
  end

  def name
    if object.info
      object.info.name
    else
      "New Beaver"
    end
  end

  def require_info
    object.info && object.info.required
  end

  def school
    if object.current_group
      object.current_group.school.name
    else
      "No current school"
    end
  end
end
