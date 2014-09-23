class Edu::Ugroup < ActiveRecord::Base
  include Concerns::Edu::GroupEnrolls
  resourcify :roles, role_cname: "Acn::Role"

  belongs_to :school, class_name: "Edu::School"
  belongs_to :cluster, class_name: "Edu::Cluster"

  counter_culture :school, column_name: "ugroups_count"
  counter_culture :cluster, column_name: "ugroups_count"

  structure do
    name  ""
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
