Group.create!([
  { name: 'Administrators', name_format: '<strong><font color="ce0000">%s</font></strong>', priority: 1000 },
  { name: 'Moderators', name_format: '<strong><font color="0000ff">%s</font></strong>', priority: 900 },
  { name: 'Registered Users', default_group: true, priority: 10 },
  { name: 'Guests', guest_group: true }
])
PermissionCategory.create!([
  { name: 'Administration' },
  { name: 'Moderation' },
  { name: 'General' }
])
Permission.create!([
  { name: 'can_see_disabled_threads', category: PermissionCategory.find_by(name: 'Moderation'), value_type: :boolean, default_value: 'false' },
  { name: 'can_see_disabled_posts', category: PermissionCategory.find_by(name: 'Moderation'), value_type: :boolean, default_value: 'false' }
])
PermissionToGroup.create!([
  { permission: Permission.find_by(name: 'can_see_disabled_threads'), group: Group.find_by(name: 'Administrators'), value: 'true' },
  { permission: Permission.find_by(name: 'can_see_disabled_threads'), group: Group.find_by(name: 'Moderators'), value: 'true' },
  { permission: Permission.find_by(name: 'can_see_disabled_posts'), group: Group.find_by(name: 'Administrators'), value: 'true' },
  { permission: Permission.find_by(name: 'can_see_disabled_posts'), group: Group.find_by(name: 'Moderators'), value: 'true' }
])
BoardPermission.create!([
  { name: 'can_access_board', default_value: true },
  { name: 'can_see_disabled_threads', default_value: false },
  { name: 'can_see_disabled_posts', default_value: false }
])
