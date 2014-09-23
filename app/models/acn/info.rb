class Acn::Info < ActiveRecord::Base
  belongs_to :user, touch: true

  structure do
    name ""
    phone ""
    gender 0
    birth :datetime

    timestamps
  end

  def required
    self.name.blank?
  end
end
