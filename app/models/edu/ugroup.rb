class Edu::Ugroup < ActiveRecord::Base
  include Concerns::Edu::GroupEnrolls
  include Concerns::Edu::Contestable
  resourcify :roles, role_cname: "Acn::Role"

  structure do
    name  ""
    exdate :datetime
    extime 0
    grade 10
    note ""
    gcode ""

    enrollments_count 0

    timestamps
  end
end
