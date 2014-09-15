module Concerns::User::Console
  extend ActiveSupport::Concern

  included do
  end

  def is_teacher_applicant
    self.xrole.name == "teacher_applicant"
  end
end
