# ## Schema Information
#
# Table name: `holders`
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

class Holder < ActiveRecord::Base
  include Concerns::SchoolSummary
  structure do
    name "", validates: {presence: true}

    schools_count 0
    groups_count 0
    users_count 0
    # timestamps
  end
end

