class User::InfoSerializer < ActiveModel::Serializer
  # object should from user
  root false
  attributes :name, :email, :phone, :id, :school
  has_one :xrole, key: :role, serializer: RoleSerializer

  def school
    return object.ugroups[0].school.name if has_school(object)
    "No School"
  end

  def phone
    return object.info.phone if object.info
    "No Data"
  end

  def name
    return object.info.name if object.info
    "No name"
  end

  def has_school obj
    (obj.ugroups.count > 0) && (obj.ugroups[0].school)
  end

end
