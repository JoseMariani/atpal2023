class AdminPolicy < Struct.new(:user, :dashboard)

  def index?
    user.admin?
  end

  def academic?
    user.admin? || user.coordinator? || user.teacher?
  end

end