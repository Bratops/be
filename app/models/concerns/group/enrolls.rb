module Concerns::Group::Enrolls
  extend ActiveSupport::Concern
  included do
    has_many :enrollments
    has_many :users, through: :enrollments, dependent: :destroy
  end

  def update_enrollment data
    opt = data.merge!({:status => "added"})
    en = self.enrollments.find_or_create_by(opt)
    en
  end

  def enroll user
    self.enrollments.find_or_create_by(user_id: user.id, ugroup_id: self.id)
  end

  def enroll! user, opt={}
    en = self.enrollments.find_by(opt)
    en && en.update(user_id: user.id)
  end
end
