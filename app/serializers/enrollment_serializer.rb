class EnrollmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :gender, :suid, :seat, :status

  def status
    object.status_hash
  end

  def gender
    object.gender == 0 ? "女" : "男"
  end
end
