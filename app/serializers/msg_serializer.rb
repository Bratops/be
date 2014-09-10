class MsgSerializer < ActiveModel::Serializer
  root false
  attributes :id, :title, :body, :start_time, :end_time

  def start_time
    object.start_time.strftime("%Y/%m/%d")
  end

  def end_time
    object.end_time.strftime("%Y/%m/%d")
  end
end
