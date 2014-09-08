class Enrollment < ActiveRecord::Base
  # make user has_many groups instead of has_one group
  belongs_to :user
  belongs_to :ugroup
  counter_culture [:user]
  counter_culture [:ugroup]

  structure do
    timestamps
  end
end

