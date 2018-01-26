class AddGroupNameFormats < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :name_format, :string, default: '%s', after: :name
  end
end
