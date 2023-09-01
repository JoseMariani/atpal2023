class StatementPolicy < ApplicationPolicy

  def initialize(user, statement)
    @user = user
    @statement = statement
  end

  def index?
    user.admin? || user.marketer?
  end

  def show?
    user.admin? || user.marketer?
  end

  def edit?
    user.admin? || user.marketer?
  end

  def update?
    user.admin? || user.marketer?
  end

  def new?
    user.admin? || user.marketer?
  end

  def create?
    user.admin? || user.marketer?
  end

  def delete?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
