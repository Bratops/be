class UserInfoSerializer < ActiveModel::Serializer
  # object should from user
  root false
  attributes :name, :email, :phone, :id, :school

  def school
    return object.ugroups[0].school.name if has_school(object)
    "No School"
  end

  def phone
    return object.user_info.phone if object.user_info
    "No Data"
  end

  def name
    return object.user_info.name if object.user_info
    "No name"
  end

  def has_school obj
    (obj.ugroups.count > 0) && (obj.ugroups[0].school)
  end
end
