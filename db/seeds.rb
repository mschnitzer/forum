Group.create!([
  { name: 'Administrators', name_format: '<strong><span color="ff0000">%s</span></strong>' },
  { name: 'Moderators', name_format: '<strong><span color="0000ff">%s</span></strong>' },
  { name: 'Registered Users', default_group: true },
  { name: 'Guests', guest_group: true }
])
PermissionCategory.create!([
  { name: 'Administration' },
  { name: 'Moderation' },
  { name: 'General' }
])
Permission.create!([
  { name: 'can_see_disabled_threads', category: PermissionCategory.find_by(name: 'Moderation'), value_type: :boolean, default_value: 'false' }
])
PermissionToGroup.create!([
  { permission: Permission.find_by(name: 'can_see_disabled_threads'), group: Group.find_by(name: 'Administration'), value: 'true' },
  { permission: Permission.find_by(name: 'can_see_disabled_threads'), group: Group.find_by(name: 'Moderation'), value: 'true' }
])
BoardPermission.create!([
  { name: 'can_access_board', default_value: true },
  { name: 'can_see_disabled_threads', default_value: false }
])
