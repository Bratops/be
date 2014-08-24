class Group < ActiveRecord::Base
  structure do
    name  ""
    group_type 0    # 0: class, 1: team
    year Time.now.year
    timestamps
  end
end

