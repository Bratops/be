class Edu::Cluster < ActiveRecord::Base
  has_many :groups, class_name: "Edu::Ugroup"

  structure do
    name "", validates: [ :presence, :uniqueness ]

    ugroups_count 0
    groups_users_count 0
    # timestamps
  end
end
