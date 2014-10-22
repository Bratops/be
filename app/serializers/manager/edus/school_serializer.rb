class Manager::Edus::SchoolSerializer < ActiveModel::Serializer
  root false
  attributes :id, :name
  has_many :items, serializer: Manager::Edus::UgroupSerializer

  def items
    gs = object.ugroups
    if scope[:user].role_named? :manager
      gs = gs.where("name != 'teacher'")
    end
    gs.paginate(scope[:pager])
  end

end
