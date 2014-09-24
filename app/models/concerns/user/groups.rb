module Concerns::User::Groups
  extend ActiveSupport::Concern

  included do
    belongs_to :current_group, class_name: "Edu::Ugroup"
    has_many :enrollments, class_name: "Acn::Enrollment"
    has_many :ugroups, class_name: "Edu::Ugroup", through: :enrollments
  end

  def add_group group
    self.ugroups.append group
  end

  def set_current_group group
    sg = self.ugroups.where(id: group.id).first
    if sg
      self.current_group = sg
      self.save
    else
      group.enroll self
      self.current_group = group
      self.save
    end
    sg
  end

  def current_group_is group
    self.current_group.id == group.id
  end

  def leave_current_group
    sg = self.current_group
    en = self.enrollments.where(ugroup: sg)
    if en.delete
      self.current_group = nil
      self.save
    end
  end

  def bebras_group
    sc = Edu::School.find_by(moeid: "0004")
    sc
  end
end
