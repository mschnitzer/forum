Group.create!([
  { name: 'Administrators' },
  { name: 'Moderators' },
  { name: 'Registered Users', default_group: true },
  { name: 'Guests', guest_group: true }
])
