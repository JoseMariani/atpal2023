class StudentsControllerPolicy < ApplicationPolicy
  attr_reader :user, :ctrlr

  def initialize(user, ctrlr)
    @user = user
    @ctrlr = ctrlr
  end

  def index?
    user.admin? or user.coordinator? or user.teacher? or user.marketer?
  end

  def student_list?
    user.admin? || user.agent? || user.marketer?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
