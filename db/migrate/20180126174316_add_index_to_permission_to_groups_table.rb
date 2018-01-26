class AddIndexToPermissionToGroupsTable < ActiveRecord::Migration[5.1]
  def change
    add_index :permission_to_groups, [:group_id, :permission_id], unique: true
  end
end
