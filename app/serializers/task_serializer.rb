# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  body       :string(255)
#  quest      :string(255)
#  explain    :string(255)
#  info       :string(255)
#  link       :string(255)
#  region     :string(255)
#  updated_at :datetime
#  created_at :datetime
#  old_id     :integer
#  tid        :string(255)
#
class TaskSerializer < ActiveModel::Serializer
  cached
  root false
  attributes :tid, :name, :body, :quest, :year

  def year
    object.created_at.year
  end

  def cache_key
    [object, scope]
  end
end
