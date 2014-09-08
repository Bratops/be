module Concerns::SchoolSummary
  extend ActiveSupport::Concern
  include do
    has_many :schools
    has_many :ugroups, through: :schools
    has_many :users, through: :ugroups
  end
end
