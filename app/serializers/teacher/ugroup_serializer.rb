class Teacher::UgroupSerializer < ActiveModel::Serializer
  root false
  attributes :id, :name, :gcode, :cyear, :removable

  def cyear
    object.created_at.year - 1911
  end

  def exdate
    #object.exdate.strftime("%Y/%m/%d")
  end

end
