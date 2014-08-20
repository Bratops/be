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
#  ttype      :string(255)
#  tid        :string(255)
#  slug       :string(255)
end

