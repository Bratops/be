module Concerns::Edu::Enrolls
  extend ActiveSupport::Concern
  included do
    #before_create :link_user
  end

  def join_user user
    self.user = user
    self.status = "joined"
    self.save
  end

  def link_user
    return if self.user && self.user.has_role?(:teacher)
    self.user = find_enrolled_user
    self.user = create_enrolled_user if self.user.nil?
  end

  def link_user!
    link_user
    self.save
  end

  def status_hash
    {
      name: I18n.t(self.status, scope: "teacher.ugroups.enroll.status"),
      value: self.status
    }
  end

  def contestable
    is_today = self.ugroup.exdate.today?
    is_sec = (self.ugroup.extime == timecode)
    is_today && is_sec
  end

  def reset_password
    return false if self.user.nil?
    self.user.password = "#{self.ugroup.gcode}#{self.suid}"
    self.user.save
  end

  module ClassMethods
    def no_student_enroll
      where(user: nil).where("suid is not null")
    end

    def link_all_students
      no_student_enroll.each do |en|
        en.link_user!
      end
    end

  end

  private

  def timecode
    tm = Time.now.change(hour: 12, min: 30, sec: 0)
    ta = Time.now.change(hour: 18, min: 0, sec: 0)
    return 0 if Time.now < tm
    return 1 if ta > Time.now && Time.now > tm
    return 2
  end

  def sid
    "#{self.ugroup.school.moeid}-#{self.suid}"
  end

  def enrollment_params
    {email: "#{sid}@bebras.tw", login_alias: sid.downcase}
  end

  def password_param
    {password: "#{self.ugroup.gcode}#{self.suid}"}
  end

  def find_enrolled_user
    User.find_by(enrollment_params)
  end

  def create_enrolled_user
    user_params = enrollment_params.merge(password_param)
    @user = User.create(user_params)
    create_user_info if @user.errors.empty?
    @user
  end

  def create_user_info
    @user.info = Acn::Info.create(name: self.name, gender: self.gender)
    @user.save
  end
end
