class BoardPolicy < ApplicationPolicy
  def show?
    board_permission = BoardPermission.find_by(name: 'can_access_board')
    permissions = record.board_permission_to_targets.where(permission: board_permission)

    # if the user does not have permissions to access the board's parent, the access will be denied
    return false if record.parent && !Pundit.policy(user, record.parent).show?

    # verify permissions: prefer user specific permissions over group permissions
    user_permission = permissions.find_by(user: user)
    return user_permission.value if user_permission

    group_permissions = permissions.where(group: user.groups)
    if group_permissions.size > 0
      group_permissions.each do |group|
        return true if group.value
      end

      return false
    end

    board_permission.default_value
  end
end
