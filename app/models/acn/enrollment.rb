class Acn::Enrollment < ActiveRecord::Base
  include Concerns::Edu::Enrolls
  resourcify :roles, role_cname: "Acn::Role"
  belongs_to :user
  counter_culture :user, column_name: "enrollments_count"

  belongs_to :ugroup, class_name: "Edu::Ugroup"
  counter_culture :ugroup, column_name: "enrollments_count"
  counter_culture [:ugroup, :cluster], column_name: "enrollments_count"
  counter_culture [:ugroup, :school], column_name: "enrollments_count"
  counter_culture [:ugroup, :school, :level], column_name: "enrollments_count"
  counter_culture [:ugroup, :school, :loc], column_name: "enrollments_count"
  counter_culture [:ugroup, :school, :holder], column_name: "enrollments_count"

  structure do
    name "", validates: { length: { in: 2..26 }}
    gender 0, validates: { inclusion: { in: 0..1}}  # 0 female
    suid "", validates: { length: { minimum: 4}}
    seat 0, default: nil
    status "added"

    timestamps
  end
end
