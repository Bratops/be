class Contest::Reg < ActiveRecord::Base
  belongs_to :contest, class_name: "Contest::Info"
  counter_culture :contest, column_name: "regs_count"

  belongs_to :ugroup, class_name: "Edu::Ugroup"
  counter_culture :ugroup, column_name: "regs_count"

  structure do
    exdate :datetime
    extime -1

    timestamps
  end
end
