# ## Schema Information
#
# Table name: `groups`
#
# ### Columns
#
# Name               | Type               | Attributes
# ------------------ | ------------------ | ---------------------------
# **`id`**           | `integer`          | `not null, primary key`
# **`name`**         | `string(255)`      |
# **`group_type`**   | `integer`          |
# **`updated_at`**   | `datetime`         |
# **`created_at`**   | `datetime`         |
# **`school_id`**    | `integer`          |
# **`users_count`**  | `integer`          |
#

class Ugroup < ActiveRecord::Base
  has_many :enrollments
  has_many :users, through: :enrollments, dependent: :destroy
  belongs_to :school
  counter_culture [:school, :location]
  counter_culture [:school, :holder]
  counter_culture [:school, :age_level]
  counter_culture [:school]
  structure do
    name  ""
    group_type 0    # 0: class, 1: team

    enrollments_count 0
    users_count 0

    timestamps
  end

  def enroll user
    self.enrollments.find_or_create_by(user_id: user.id, ugroup_id: self.id)
  end
end

