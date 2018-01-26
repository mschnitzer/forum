class AddDefaultValueToBoardPermissions < ActiveRecord::Migration[5.1]
  def change
    add_column :board_permissions, :default_value, :boolean, null: false
  end
end
