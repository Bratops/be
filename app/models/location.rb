class Location < ActiveRecord::Base
  has_many :schools
  has_many :groups, through: :schools
  structure do
    name "", validates: {presence: true}
    loc_level 0 # N.E.W.S.

    groups_count 0
    schools_count 0

    # timestamps
  end
end

