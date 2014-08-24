# ## Schema Information
#
# Table name: `tasks`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`name`**        | `string(255)`      |
# **`body`**        | `text`             |
# **`quest`**       | `text`             |
# **`explain`**     | `text`             |
# **`info`**        | `text`             |
# **`link`**        | `text`             |
# **`region`**      | `string(255)`      |
# **`tid`**         | `string(255)`      |
# **`old_id`**      | `integer`          |
# **`updated_at`**  | `datetime`         |
# **`created_at`**  | `datetime`         |
#

class Task < ActiveRecord::Base
  structure do
    name               " New Task                  "
    body               :text, " A question context.       "
    quest              :text, " What should be solved?    "
    explain            :text, " This is what the task is. "
    info               :text, " Some information          "
    link               :text, " http://bebras.tw/newtask  "
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

