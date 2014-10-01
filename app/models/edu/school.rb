class Edu::School < ActiveRecord::Base
  include Concerns::Edu::SchoolAdmin

  structure do
    name "", validates: [ :presence, :uniqueness ]
    moeid "", validates: {presence: true, format: /\A\w{4,6}\z/  }

    ugroups_count 0
    enrollments_count 0

    timestamps
  end
end
