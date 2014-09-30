class Acn::Enrollment < ActiveRecord::Base
  include Concerns::Edu::Enrolls
  resourcify :roles, role_cname: "Acn::Role"
  # make user has_many groups instead of has_one group
  belongs_to :user
  counter_culture :user, column_name: "enrollments_count"

  belongs_to :ugroup, class_name: "Edu::Ugroup"
  counter_culture :ugroup, column_name: "enrollments_count"
  counter_culture [:ugroup, :cluster], column_name: "groups_users_count"

  structure do
    name "", validates: { length: { in: 2..26 }}
    gender 0, validates: { inclusion: { in: 0..1}}  # 0 female
    suid "", validates: { length: { minimum: 4}}
    seat 0, default: nil
    status "added"

    timestamps
  end

  def status_hash
    {
      name: I18n.t(self.status, scope: "teacher.ugroups.enroll.status"),
      value: self.status
    }
  end
end
