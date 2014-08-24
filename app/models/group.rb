class Group < ActiveRecord::Base
  belongs_to :school
  counter_culture [:school, :location]
  counter_culture [:school]
  structure do
    name  ""
    group_type 0    # 0: class, 1: team
    year Time.now.year

    timestamps
  end
end

