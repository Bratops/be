class School < ActiveRecord::Base
  has_many :ugroups
  has_many :enrollments, through: :ugroups
  has_many :users, through: :enrollments
  belongs_to :location
  belongs_to :holder
  belongs_to :age_level
  counter_culture [:location]
  counter_culture [:holder]
  counter_culture [:age_level]
  structure do
    name "", validates: [ :presence, :uniqueness ]
    moeid "", validates: {presence: true, format: /\A\w{4,6}\z/  }

    users_count 0
    ugroups_count 0
    timestamps
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

