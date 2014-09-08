# ## Schema Information
#
# Table name: `age_levels`
#
# ### Columns
#
# Name                 | Type               | Attributes
# -------------------- | ------------------ | ---------------------------
# **`id`**             | `integer`          | `not null, primary key`
# **`name`**           | `string(255)`      |
# **`schools_count`**  | `integer`          |
# **`groups_count`**   | `integer`          |
# **`users_count`**    | `integer`          |
#

class AgeLevel < ActiveRecord::Base
  include Concerns::SchoolSummary
  structure do
    name "", validates: [ :presence, :uniqueness ]

    schools_count 0
    ugroups_count 0
    users_count 0
    # timestamps
  end
end

