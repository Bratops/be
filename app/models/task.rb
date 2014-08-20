class Task < ActiveRecord::Base
  structure do
    name               " New Task                  "
    body               " A question context.       "
    quest              " What should be solved?    "
    explain            " This is what the task is. "
    info               " Some information          "
    link               " http://bebras.tw/newtask  "
    region             " TW                        "
    tid                "AA-bbbb-cc"
    old_id             -1
    timestamps
  end
  scope :in_year, lambda {|y| where("created_at >= ? and created_at < ?", Time.mktime(y, 1), Time.mktime(y+1, 1)) }
#  ttype      :string(255)
#  tid        :string(255)
#  slug       :string(255)
end

