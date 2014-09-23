class Edu::Ugroup < ActiveRecord::Base
  include Concerns::Edu::GroupEnrolls
  resourcify

  belongs_to :school, class_name: "Edu::School"

  counter_culture [:school, :loc]
  counter_culture [:school, :holder]
  counter_culture [:school, :level]
  counter_culture [:school]

  structure do
    name  ""
    klass 0
    exdate :datetime
    extime 0
    grade 10
    note ""
    gcode ""

    enrollments_count 0
    users_count 0

    timestamps
  end

  before_create :ensure_gcode
  def ensure_gcode
    # start from 3, with 6 chars
    self.gcode = Devise.friendly_token[3,6]
  end

  def ensure_gcode!
    self.ensure_gcode
    self.save
  end
end
