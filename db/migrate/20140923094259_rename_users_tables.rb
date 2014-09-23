class RenameUsersTables < ActiveRecord::Migration
  def change
    rename_table :roles, :acn_roles
    rename_table :user_infos, :acn_infos
    rename_table :users_roles, :users_acn_roles
    rename_table :enrollments, :acn_enrollments
  end
end
