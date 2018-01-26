class AddPermissionTables < ActiveRecord::Migration[5.1]
  def change
    create_table :permissions do |t|
      t.string :name
      t.text :description
      t.integer :value_type
      t.text :default_value, limit: 16777215
    end

    create_table :permission_to_groups do |t|
      t.integer :permission_id
      t.integer :group_id
      t.text :value, limit: 16777215
    end
  end
end
