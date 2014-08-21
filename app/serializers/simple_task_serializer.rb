class SimpleTaskSerializer < ActiveModel::Serializer
  root false
  attributes :qid, :name

  def qid
    "#{year}-#{object.region}-#{object.tid}"
  end

  def year
    object.created_at.year
  end
end
