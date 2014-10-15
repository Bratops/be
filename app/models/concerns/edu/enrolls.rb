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
    sid = "#{self.ugroup.school.moeid}-#{self.suid}"
    u = User.find_by(email: "#{sid}@bebras.tw", login_alias: sid.downcase)
    if u.nil?
      u = User.create(email: "#{sid}@bebras.tw", login_alias: sid, password: "#{self.ugroup.gcode}#{self.suid}")
      if u
        u.info = Acn::Info.create(name: self.name, gender: self.gender)
        u.save
      end
    end
    self.user = u
  end

  def link_user!
    self.link_user
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

  private

  def timecode
    tm = Time.now.change(hour: 12, min: 30, sec: 0)
    ta = Time.now.change(hour: 18, min: 0, sec: 0)
    return 0 if Time.now < tm
    return 1 if ta > Time.now && Time.now > tm
    return 2
  end
end
