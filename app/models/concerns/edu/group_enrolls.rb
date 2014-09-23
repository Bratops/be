module Concerns::Edu::GroupEnrolls
  extend ActiveSupport::Concern
  included do
    has_many :enrollments
    has_many :users, through: :enrollments, dependent: :destroy
  end

  def update_enrollment data
    opt = data.merge!({:status => "added"})
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

  def deroll user
    if user.current_group_is self
      user.set_no_group
    end
    en = self.enrollments.find_by(user: user)
    en.delete
  end
end
