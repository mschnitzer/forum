Group.create!([
  { name: 'Administrators', name_format: '<strong><span color="ff0000">%s</span></strong>' },
  { name: 'Moderators', name_format: '<strong><span color="0000ff">%s</span></strong>' },
  { name: 'Registered Users', default_group: true },
  { name: 'Guests', guest_group: true }
])
