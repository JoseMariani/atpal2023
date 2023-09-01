class StudentPolicy < ApplicationPolicy
  attr_reader :user, :student

  def initialize(user, student)
    @user = user
    @student = student
  end

  def index?
    user.admin? || user.agent? || user.marketer?
  end

  def student_list?
    user.admin? || user.agent? || user.marketer?
  end

  def show?
    user.admin? || user.agent? || user.marketer?
  end

  def edit?
    user.admin? || user.agent? || user.marketer?
  end

  def update?
    user.admin? || user.agent? || user.marketer?
  end

  def new?
    user.admin? || user.agent? || user.marketer?
  end

  def create?
    user.admin? || user.agent? || user.marketer?
  end

  def delete?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def active?
    user.admin? or user.coordinator?
  end

  def activate?
    user.admin?
  end

  def deactivate?
    user.admin?
  end

  def edit_multiple?
    user.admin? or user.coordinator?
  end

  def update_multiple?
    user.admin? or user.coordinator?
  end

  def batch_edit?
    user.admin? or user.coordinator? or user.teacher?
  end

  class Scope < StudentPolicy
    attr_reader :user, :scope
    
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if @user.marketer?
        @scope.where(agency_id: @user.agencies)
      else
        @scope
      end
    end
  end
end
