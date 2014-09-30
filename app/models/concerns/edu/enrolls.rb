module Concerns::Edu::Enrolls
  extend ActiveSupport::Concern
  included do
    before_create :link_user
  end

  def join_user user
    self.user = user
    self.status = "joined"
    self.save
  end

  def link_user
    sid = "#{self.ugroup.school.moeid}-#{self.suid}"
    u = User.find_by(email: "#{sid}@bebras.tw", login_alias: sid)
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
end
