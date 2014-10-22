class Manager::Edus::UgroupSerializer < ActiveModel::Serializer
  root false
  attributes :id, :name, :teacher, :enrollments_count

  def teacher
    object.teacher ? object.teacher.info.name : ""
  end
end
