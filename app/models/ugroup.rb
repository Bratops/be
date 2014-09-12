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
  include Concerns::Group::Enrolls
  resourcify

  belongs_to :school

  counter_culture [:school, :location]
  counter_culture [:school, :holder]
  counter_culture [:school, :age_level]
  counter_culture [:school]

  structure do
    name  ""
    klass 0
    exdate :datetime
    extime 0
    grade 10
    note ""
    gcode ""

    enrollments_count 0
    users_count 0

    timestamps
  end

  before_create :ensure_gcode
  def ensure_gcode
    # start from 3, with 6 chars
    self.gcode = Devise.friendly_token[3,6]
  end

  def ensure_gcode!
    self.ensure_gcode
    self.save
  end

end

