module Concerns::SchoolSummary
  extend ActiveSupport::Concern
  include do
    has_many :schools
    has_many :groups, through: :schools
    has_many :users, through: :groups
  end
end
