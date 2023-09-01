class InsurancePolicy < ApplicationPolicy

  def initialize(user, insurance)
    @user = user
    @insurance = insurance
  end

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
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def update_insurance_cost?
    user.admin? || user.marketer?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
