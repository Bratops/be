class Menu < ActiveRecord::Base
  acts_as_nested_set order_column: :pos,
    counter_cache: :children_count
  resourcify :roles, role_cname: "Acn::Role"

  structure do
    klass "admin"  # 0: menu, 1: ...
    name "", validates: { length: { in: 2..20 }}
    desc ""
    icon ""
    link ""
    tube ""
    info_link ""
    pos 0

    children_count 0
    parent_id 0, index: true, default: nil
    lft 0, index: true, default: nil
    rgt 0, index: true, default: nil
    depth 0, default: nil

    timestamps
  end

  def self.role_menu role
    self.find_by(name: "dashboard_#{role.to_s}")
  end
end

