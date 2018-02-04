class AddPriorityToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :priority, :integer, default: 0, null: false

    Group.find_by(name: 'Administrators').update(priority: 1000)
    Group.find_by(name: 'Moderators').update(priority: 900)
    Group.find_by(name: 'Registered Users').update(priority: 10)
  end
end
