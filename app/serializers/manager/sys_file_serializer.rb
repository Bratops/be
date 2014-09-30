class Manager::SysFileSerializer < ActiveModel::Serializer
  root false
  attributes :name, :code, :down_count, :size, :url

  def code
    object.fcode
  end

  def size
    object.share.size
  end

  def url
    "http://#{ENV["host_back"]}/files/#{object.fcode}"
  end
end
