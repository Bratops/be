# ## Schema Information
#
# Table name: `locations`
#
# ### Columns
#
# Name                 | Type               | Attributes
# -------------------- | ------------------ | ---------------------------
# **`id`**             | `integer`          | `not null, primary key`
# **`name`**           | `string(255)`      |
# **`groups_count`**   | `integer`          | `not null`
# **`schools_count`**  | `integer`          | `not null`
# **`users_count`**    | `integer`          |
#

class Location < ActiveRecord::Base
  include Concerns::SchoolSummary
  structure do
    name "", validates: [ :presence, :uniqueness ]
    #loc_level 0 # N.E.W.S.

    schools_count 0
    ugroups_count 0
    users_count 0
    # timestamps
  end
end

