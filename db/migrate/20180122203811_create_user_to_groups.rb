class CreateUserToGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :user_to_groups do |t|
      t.integer :user_id
      t.integer :group_id
    end

    add_index :user_to_groups, [:user_id, :group_id], unique: true
  end
end
