class Teacher::ContestRegSerializer < ActiveModel::Serializer
  root false
  attributes :id, :exdate, :extime
  has_one :ugroup, serializer: Teacher::UgroupSerializer
  has_one :contest, serializer: Teacher::ContestSerializer

  def exdate
    object.exdate.strftime("%Y/%m/%d")
  end

end
