class AgencyPolicy < ApplicationPolicy

  def initialize(user, agency)
    @user = user
    @agency = agency
  end

  def index?
    user.admin? || user.marketer?
  end

  def show?
    user.admin? || user.marketer?
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

  class Scope < AgencyPolicy
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if @user.marketer?
        @scope.where(id: @user.agencies)
      else
        @scope.all
      end
    end
  end
end
