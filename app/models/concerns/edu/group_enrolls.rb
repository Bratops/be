module Concerns::Edu::GroupEnrolls
  extend ActiveSupport::Concern
  included do
    has_many :enrollments, class_name: "Acn::Enrollment"
    has_many :users, through: :enrollments, dependent: :destroy

    belongs_to :school, class_name: "Edu::School"
    counter_culture :school, column_name: "ugroups_count"
  end

  def update_enrollment data
    opt = data.merge!({:status => "joined"})
    en = self.enrollments.find_by_id(data[:id])
    opt.delete :id
    if en
      en.update(opt)
    else
      en = self.enrollments.create(opt)
    end
    en
  end

  def enroll user
    opts = { user: user }
    en = self.enrollments.find_by(opts)
    unless en
      en = self.enrollments.new(opts)
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

end
