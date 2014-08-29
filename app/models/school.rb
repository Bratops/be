# ## Schema Information
#
# Table name: `schools`
#
# ### Columns
#
# Name                | Type               | Attributes
# ------------------- | ------------------ | ---------------------------
# **`id`**            | `integer`          | `not null, primary key`
# **`name`**          | `string(255)`      |
# **`moeid`**         | `string(255)`      |
# **`updated_at`**    | `datetime`         |
# **`created_at`**    | `datetime`         |
# **`groups_count`**  | `integer`          |
# **`location_id`**   | `integer`          |
# **`age_level_id`**  | `integer`          |
# **`holder_id`**     | `integer`          |
# **`users_count`**   | `integer`          |
#

class School < ActiveRecord::Base
  has_many :groups
  has_many :users, through: :groups
  belongs_to :location
  belongs_to :holder
  belongs_to :age_level
  counter_culture [:location]
  counter_culture [:holder]
  counter_culture [:age_level]
  structure do
    name "", validates: [ :presence, :uniqueness ]
    moeid "", validates: {presence: true, format: /\A\w{4,6}\z/  }

    users_count 0
    groups_count 0
    timestamps
  end

  def alumnus
    self.groups.where(name: "alumnus").first
  end

  before_create :ensure_default_group
  def ensure_default_group
    gp = Group.mock(name: "alumnus")
    gp.save
    self.groups << gp
  end

  def update_counter
    self.counter_culture_fix_counts
  end
end

