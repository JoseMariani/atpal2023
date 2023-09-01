class TestPolicy < ApplicationPolicy

  def initialize(user, test)
    @user = user
    @test = test
  end

  def index?
    user.admin? or user.coordinator?
  end

  def show?
    user.admin? or user.coordinator? or user.teacher?
  end

  def edit?
    user.admin? or user.coordinator?
  end

  def update?
    user.admin? or user.coordinator?
  end

  def new?
    user.admin? or user.coordinator?
  end

  def create?
    user.admin? or user.coordinator?
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
