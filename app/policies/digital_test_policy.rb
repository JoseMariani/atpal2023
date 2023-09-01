class DigitalTestPolicy < ApplicationPolicy

  def initialize(user, digital_test)
    @user = user
    @digital_test = digital_test
  end

  def index?
    user.admin? or user.coordinator?
  end

  def show?
    user.admin? or user.coordinator?
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
    user.admin? or user.coordinator?
  end

  def destroy?
    user.admin? or user.coordinator?
  end
  class Scope < Scope
    def resolve
      scope
    end
  end
end
