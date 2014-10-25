class Teacher::UgroupEditSerializer < ActiveModel::Serializer
  root false
  attributes :id, :name, :cluster_id, :grade, :gcode, :removable
  has_many :enrolls, serializer: Teacher::EnrollmentSerializer

  def enrolls
    object.enrollments
  end
end
