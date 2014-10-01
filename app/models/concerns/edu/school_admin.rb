module Concerns::Edu::SchoolAdmin
  extend ActiveSupport::Concern

  included do
    has_many :ugroups, class_name: "Edu::Ugroup", foreign_key: :school_id
    has_many :enrollments, class_name: "Acn::Enrollment", through: :ugroups
    has_many :users, through: :enrollments

    belongs_to :level, class_name: "Edu::Level"
    counter_culture :level, column_name: "schools_count"

    belongs_to :loc, class_name: "Edu::Loc"
    counter_culture :loc, column_name: "schools_count"

    belongs_to :holder, class_name: "Edu::Holder"
    counter_culture :holder, column_name: "schools_count"
  end

  def alumnus
    self.ugroups.where(name: "alumnus").first
  end

  def add_ugroup name, user
    sg = self.ugroups.find_or_create_by(name: name)
    sg.enroll user
    sg
  end

  def add_alumnus user
    self.add_ugroup "alumnus", user
  end

  def add_teacher user
    sg = self.add_ugroup "teacher", user
    user.set_current_group sg
  end

  def self.bebras_team
    find_by(moeid: "0004")
  end
end
