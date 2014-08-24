class School < ActiveRecord::Base
  has_many :groups
  has_many :users, through: :groups
  belongs_to :location
  belongs_to :holder
  belongs_to :age_level
  counter_culture [:location]
  counter_culture [:holder]
  counter_culture [:age_level]
  structure do
    name "", validates: {presence: true}
    moeid "", validates: {presence: true, format: /\A\w{6}\z/  }

    users_count 0
    groups_count 0
    timestamps
  end
end

