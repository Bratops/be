class Edu::Holder < ActiveRecord::Base
  include Concerns::Edu::SchoolSummary

  structure do
    name "", validates: [ :presence, :uniqueness ]

    schools_count 0
    ugroups_count 0
    users_count 0
    # timestamps
  end
end
