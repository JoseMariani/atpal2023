class UserPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def show?
    user.admin?
  end

  def edit?
    user.admin?
  end

  def update?
    user.admin?
  end

  def new?
    user.admin?
  end

  def create?
    user.admin?
  end

  def delete?
    return false if @user == @record
    user.admin?
  end

  def destroy?
    return false if @user == @record
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
