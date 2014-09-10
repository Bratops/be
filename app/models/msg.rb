class Msg < ActiveRecord::Base
  structure do
    title ""
    body ""
    start_time :datetime
    end_time :datetime
    timestamps
  end
end

