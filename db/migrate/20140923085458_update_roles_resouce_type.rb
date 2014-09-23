class UpdateRolesResouceType < ActiveRecord::Migration
  def up
    roles = Role.where(resource_type: "Ugroup")
    roles.update_all(resource_type: "Edu::Ugroup")
  end
end
