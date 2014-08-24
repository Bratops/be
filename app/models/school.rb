class School < ActiveRecord::Base
  has_many :groups
  belongs_to :location
  counter_culture [:location]
  structure do
    name
    moeid "", validates: {presence: true, format: /\A\w{6}\z/  }

    groups_count 0
    timestamps
  end
end

