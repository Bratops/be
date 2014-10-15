module Concerns::Edu::GroupEnrolls
  extend ActiveSupport::Concern
  included do
    has_many :enrollments, class_name: "Acn::Enrollment"
    has_many :users, through: :enrollments, dependent: :destroy

    belongs_to :cluster, class_name: "Edu::Cluster"
    counter_culture :cluster, column_name: "ugroups_count"

    belongs_to :school, class_name: "Edu::School"
    counter_culture :school, column_name: "ugroups_count"
    counter_culture [:school, :level], column_name: "ugroups_count"
    counter_culture [:school, :loc], column_name: "ugroups_count"
    counter_culture [:school, :holder], column_name: "ugroups_count"

    before_create :ensure_gcode
  end

  def batch_link_users
    self.enrollments.each do |en|
      en.link_user!
    end
  end

  def batch_reset_eupw
    self.enrollments.each do |en|
      user = en.user
      user.password = self.gcode + en.suid
      user.save
    end
  end

  def update_enrollment data
    opt = data.merge!({:status => "joined"})
    en = self.enrollments.find_by_id(data[:id])
    opt.delete :id
    if en
      en.update(opt)
    else
      en = self.enrollments.create(opt)
      en.link_user!
    end
    en
  end

  def enroll user
    opts = { user: user }
    en = self.enrollments.find_by(opts)
    unless en
      en = self.enrollments.new(name: user.info.name, gender: 0, suid: "000000")
      en.user = user
      en.save(validate: false)
    end
    en
  end

  def enroll_new user
    data = {user: user, name: user.info.name, gender: user.info.gender, suid: user.suid, status: "joined"}
    en = self.enrollments.new(data)
    en.save
  end

  def deroll user
    if user.current_group_is self
      user.set_no_group
    end
    en = self.enrollments.find_by(user: user)
    en.delete
  end

  def ensure_gcode
    # start from 3, with 6 chars
    self.gcode = Devise.friendly_token[3,6]
  end

  def ensure_gcode!
    self.ensure_gcode
    self.save
  end
end
