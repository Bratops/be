module Concerns::Edu::Contestable
  extend ActiveSupport::Concern

  included do
    has_many :ans_sheets, class_name: "Contest::AnsSheet",
      foreign_key: "ugroup_id"
  end

  def grading
    a = [ -1, 0, 0, 0, 1, 1, 1, 2, 2, 3, 3, 4, 4, 4, 4, 4]
    a[self.grade]
  end

  def grade_str
    a = [ "", "beaver", "beaver", "beaver", "cadet", "cadet", "cadet",
      "benjamin", "benjamin", "junior", "junior", "sneior", "sneior"]
    a[self.grade]
  end
end
