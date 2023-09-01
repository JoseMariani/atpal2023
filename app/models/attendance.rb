class Attendance < ActiveRecord::Base
  belongs_to :evaluation


  scope :newest_first, lambda { order("attendances.created_at DESC" )}
  scope :between, -> (start_date, end_date) { where("created_at > ? AND created_at < ?", start_date, end_date) }

  validate :check_only_one_daily, :on => :create
  validate :is_evaluation_active, :on => [:create, :update, :edit, :batch_edit, :justify_absence]

  def check_only_one_daily
    if self.evaluation.attendances.where("created_at >= ?", Time.zone.now.beginning_of_day).size >= 1
      errors.add(:attendance, "has already been registered today")
    end
  end

  def is_evaluation_active
    unless evaluation.is_active?
      errors[:base] << 'The academic profile to which this attendance belongs must be active'
    end
  end

  def justify_absence
    self.absent = "Justified Absence"
    self.hour = nil
    self.grade = nil
    self.penalty = nil
  end
end
