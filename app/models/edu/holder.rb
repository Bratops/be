class Edu::Holder < ActiveRecord::Base
  include Concerns::Edu::SchoolSummary

  structure do
    name "", validates: [ :presence, :uniqueness ]

    ugroups_count 0
    schools_count 0
    enrollments_count 0
    # timestamps
  end
end
