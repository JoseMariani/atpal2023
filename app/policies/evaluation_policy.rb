class EvaluationPolicy < ApplicationPolicy

  def index?
    user.admin? or user.coordinator? or user.teacher?
  end

  def show?
    user.admin? or user.coordinator? or user.teacher?
  end

  def edit?
    user.admin? or user.coordinator? or user.teacher?
  end

  def update?
    user.admin? or user.coordinator? or user.teacher?
  end

  def exercises?
    user.admin? or user.coordinator? or user.teacher?
  end

  def daily?
    user.admin? or user.coordinator?
  end

  def regular?
    user.admin? or user.coordinator? or user.teacher?
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

  def report?
    user.admin?
  end

  def language?
    user.admin? or user.coordinator? or user.teacher?
  end

  def level?
    user.admin? or user.coordinator? or user.teacher?
  end

  def type?
    user.admin? or user.coordinator? or user.teacher?
  end

  def set_evaluation_to_active?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
