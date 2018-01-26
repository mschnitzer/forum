class AddBoardPermissionTables < ActiveRecord::Migration[5.1]
  def change
    create_table :board_permissions do |t|
      t.string :name
    end

    create_table :board_permission_to_targets do |t|
      t.integer :permission_id
      t.integer :board_id
      t.integer :group_id
      t.integer :user_id
      t.boolean :value, null: false
    end

    add_index :board_permission_to_targets, [:permission_id, :board_id, :user_id], name: 'index_unique_board_and_user', unique: true
    add_index :board_permission_to_targets, [:permission_id, :board_id, :group_id], name: 'index_unique_board_and_group', unique: true
  end
end
