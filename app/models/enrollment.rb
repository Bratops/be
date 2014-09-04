class Enrollment < ActiveRecord::Base
  # make user has_many groups instead of has_one group
  belongs_to :user
  belongs_to :ugroup
  counter_culture [:user]
  counter_culture [:user, :ugroups]
  counter_culture [:ugroup]
  counter_culture [:ugroup, :users]

  structure do
    timestamps
  end
end

