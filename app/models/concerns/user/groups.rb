module Concerns::User::Groups
  extend ActiveSupport::Concern

  included do
    belongs_to :current_group, class_name: "Ugroup"
    has_many :enrollments
    has_many :ugroups, through: :enrollments, dependent: :destroy
  end

  def add_group group
    self.ugroups.append group
  end

  def set_current_group group
    sg = self.ugroups.where(id: group.id).first
    if sg
      self.current_group = sg
      self.save
    end
    sg
  end

end
