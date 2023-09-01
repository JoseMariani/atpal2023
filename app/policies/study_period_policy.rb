class StudyPeriodPolicy < ApplicationPolicy

  def initialize(user, period)
    @user = user
    @quiz = period
  end

  def index?
    user.admin? || user.marketer? || user.agent?
  end

  def show?
    user.admin? || user.marketer? || user.agent?
  end

  def edit?
    user.admin? || user.marketer? || user.agent?
  end

  def update?
    user.admin? || user.marketer? || user.agent?
  end

  def new?
    user.admin? || user.marketer? || user.agent?
  end

  def create?
    user.admin? || user.marketer? || user.agent?
  end

  def letter_of_acceptance?
    user.admin? || user.marketer? || user.agent?
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
