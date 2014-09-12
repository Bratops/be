class Enrollment < ActiveRecord::Base
  resourcify
  # make user has_many groups instead of has_one group
  belongs_to :user
  belongs_to :ugroup
  counter_culture [:user]
  counter_culture [:ugroup]

  structure do
    name "", validates: { length: { in: 2..6 }}
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

