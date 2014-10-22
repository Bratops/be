class Edu::Ugroup < ActiveRecord::Base
  include Concerns::Edu::GroupEnrolls
  include Concerns::Edu::Contestable
  resourcify :roles, role_cname: "Acn::Role"

  def teacher
    return nil if self.roles.size == 0
    User.joins(:roles).where(acn_roles: {id: self.roles[0].id }).first
  end

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
