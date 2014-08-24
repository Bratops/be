class AgeLevel < ActiveRecord::Base
  include Concerns::SchoolSummary
  structure do
    name "", validates: {presence: true}

    schools_count 0
    groups_count 0
    users_count 0
    # timestamps
  end
end

