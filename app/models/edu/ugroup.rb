class Edu::Ugroup < ActiveRecord::Base
  include Concerns::Edu::GroupEnrolls
  include Concerns::Edu::Contestable
  resourcify :roles, role_cname: "Acn::Role"

  def teacher
    return nil if self.roles.size == 0
    User.joins(:roles).where(acn_roles: {id: self.roles[0].id }).first
  end

  def removable
    true
  end

  scope :general , -> { where("name != 'teacher' or name != 'alumnus'") }

  scope :in_year, ->(year) { where("created_at BETWEEN ? AND ?", Time.new(year), Time.new(year+1)) }

  structure do
    name  ""
    exdate :datetime
    extime 0
    grade 10
    note ""
    gcode ""

    regs_count 0
    enrollments_count 0

    timestamps
  end
end
