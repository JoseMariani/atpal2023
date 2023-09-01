class PublicControllerPolicy < ApplicationPolicy
  attr_reader :user, :ctrlr

  def initialize(user, ctrlr)
    @user = user
    @ctrlr = ctrlr
  end

  def language?
    user.admin? or user.coordinator? or user.teacher?
  end

  def group?
    user.admin? or user.coordinator? or user.teacher?
  end

  def type?
    user.admin? or user.coordinator? or user.teacher?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
