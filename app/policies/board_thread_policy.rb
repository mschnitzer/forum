class BoardThreadPolicy < ApplicationPolicy
  def new?
    Pundit.policy(user, record.board).show?
  end

  def create?
    new?
  end

  def show?
    # deny access if user doesn't have access to the thread's board
    return false if Pundit.policy(user, record.board).show?

    if thread.disabled
      # prefer board specific permissions over global permissions
      board_permission, _ = user.board_permission?(board, :can_see_disabled_threads)

      # explicitly check for `false` as `nil` means: the access to disabled threads is not allowed nor denied
      return false if board_permission == false || (board_permission.nil? && user.permission?(:can_see_disabled_threads) == false)
    end

    true
  end

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      return scope if scope.empty?

      # board specific permissions first, then group permissions
      board = scope.first.board
      board_permission, _ = user.board_permission?(board, :can_see_disabled_threads)
      return scope.all if board_permission

      # group permissions
      if board_permission != false && user.permission?(:can_see_disabled_threads)
        scope.all
      else
        scope.where(disabled: false)
      end
    end
  end
end
