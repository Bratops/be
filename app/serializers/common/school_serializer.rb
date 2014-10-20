class Common::SchoolSerializer < ActiveModel::Serializer
  root false
  attributes :moeid, :name

  def name
    "(#{object.loc.name[0..1]})#{object.name}"
  end
end
