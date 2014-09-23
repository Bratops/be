class UgroupSerializer < ActiveModel::Serializer
  root false
  attributes :id, :name, :cluster_id, :exdate, :extime, :grade, :note
  attributes :gcode, :note

  def exdate
    object.exdate.strftime("%Y/%m/%d")
  end
end
