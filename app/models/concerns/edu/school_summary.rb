module Concerns::Edu::SchoolSummary
  extend ActiveSupport::Concern
  included do
    has_many :schools, class_name: "Edu::School"
    has_many :ugroups, class_name: "Edu::Ugroup", through: :schools
    has_many :users, class_name: "User", through: :ugroups
  end
end
