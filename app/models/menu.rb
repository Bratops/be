class Menu < ActiveRecord::Base
  acts_as_nested_set order_column: :pos, counter_cache: :children_count, dependent: :destroy
  resourcify

  structure do
    klass 0
    name ""
    desc ""
    icon ""
    link ""
    pos 0

    children_count 0
    parent_id 0, index: true
    lft 0, index: true
    rgt 0, index: true
    depth 0

    timestamps
  end
end

