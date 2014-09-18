class Holder < ActiveRecord::Base
  include Concerns::SchoolSummary
  structure do
    name "", validates: [ :presence, :uniqueness ]

    schools_count 0
    ugroups_count 0
    users_count 0
    # timestamps
  end
end

