class ProFormaPolicy < ApplicationPolicy

  def initialize(user, pro_forma)
    @user = user
    @pro_forma = pro_forma
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

  def load_config?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
