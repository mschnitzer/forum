class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.boolean :default_group, default: false, null: false
      t.boolean :guest_group, default: false, null: false
    end

    Group.create!([
      { name: 'Administrators' },
      { name: 'Moderators' },
      { name: 'Registered Users', default_group: true },
      { name: 'Guests', guest_group: true }
    ])
  end
end
