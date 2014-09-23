class Edu::School < ActiveRecord::Base
  include Concerns::Edu::SchoolAdmin
  counter_culture [:loc]
  counter_culture [:holder]
  counter_culture [:level]

  structure do
    name "", validates: [ :presence, :uniqueness ]
    moeid "", validates: {presence: true, format: /\A\w{4,6}\z/  }

    users_count 0
    ugroups_count 0
    timestamps
  end
end
