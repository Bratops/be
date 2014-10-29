class Teacher::ContestSerializer < ActiveModel::Serializer
  root false
  attributes :id, :name, :sdate, :edate

  def sdate
    object.valid_start_date.strftime("%Y/%m/%d")
  end

  def edate
    object.edate.strftime("%Y/%m/%d")
  end
end
