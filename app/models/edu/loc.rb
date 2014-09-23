class Edu::Loc < ActiveRecord::Base
  include Concerns::Edu::SchoolSummary

  structure do
    name "", validates: [ :presence, :uniqueness ]
    #loc_level 0 # N.E.W.S.

    schools_count 0
    ugroups_count 0
    users_count 0
    # timestamps
  end
end
