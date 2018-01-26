class CreatePermissionCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :permission_categories do |t|
      t.string :name
    end

    add_column :permissions, :category_id, :integer, after: :description
  end
end
