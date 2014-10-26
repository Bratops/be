class Teacher::EnrollmentSerializer < ActiveModel::Serializer
  root false
  attributes :id, :name, :gender, :suid, :seat

  def seat
    "#{object.seat}" || ""
  end
end
