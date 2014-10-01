class Edu::Loc < ActiveRecord::Base
  include Concerns::Edu::SchoolSummary

  structure do
    name "", validates: [ :presence, :uniqueness ]
    #loc_level 0 # N.E.W.S.

    ugroups_count 0
    schools_count 0
    enrollments_count 0
    # timestamps
  end
end
