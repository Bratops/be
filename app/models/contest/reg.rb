class Contest::Reg < ActiveRecord::Base
  belongs_to :contest, class_name: "Contest::Info"
  counter_culture :contest, column_name: "regs_count"

  belongs_to :ugroup, class_name: "Edu::Ugroup"
  counter_culture :ugroup, column_name: "regs_count"

  def set_today
    update(exdate: Time.zone.now.beginning_of_day)
  end

  def self.timecode
    current = Time.zone.now.beginning_of_day
    mid = current.change(hour: 12, min: 30, sec: 0)
    night = current.change(hour: 18, min: 0, sec: 0)
    return 0 if current < mid
    return 1 if (mid < current) && (current < night)
    return 2
  end

  scope :time_valid, -> { where(extime: timecode) }
  scope :date_valid, -> { where(exdate: Time.zone.now.beginning_of_day) }
  scope :available, -> { date_valid.time_valid }

  structure do
    exdate :datetime
    extime -1

    timestamps
  end
end
