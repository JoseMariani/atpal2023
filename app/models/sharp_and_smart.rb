class SharpAndSmart < ActiveRecord::Base
  belongs_to :evaluation

  COLORS = %w[white white|| gray gray|| ivory ivory|| yellow yellow|| blue blue|| green green||]

  validates :color, inclusion: {in: COLORS}

  scope :newest_first, lambda { order("sharp_and_smarts.created_at DESC" )}

  scope :between, ->(start_date, end_date) { where("created_at > ? AND created_at < ?", start_date, end_date) }

  validates_presence_of :date
  validate :is_evaluation_active, :on => [:create, :update, :edit, :batch_edit]
  validate :has_8_sns
  after_save :set_daily_score
  after_save :set_letter_grade

  def is_evaluation_active
    unless evaluation.is_active?
      errors[:base] << "The academic profile to which this attendance belongs must be active"
    end
  end

  def has_8_sns
    return if daily_sns.size < 8

    errors.add(:base, "There can only be a maximum of 8 sharp and smart exercises per day")
  end

  def daily_sns
    evaluation.sharp_and_smarts.where(date: self.date.beginning_of_day..self.date.end_of_day)
  end

  def daily_score_converted
    daily_sns.map(&:score).compact.sum / (daily_sns.count * 5.0) * 100 unless daily_sns.blank?
  end

  def set_daily_score
    local_daily_sns = daily_sns
    grade = (local_daily_sns.map(&:score).compact.sum / (local_daily_sns.count * 1.0).to_f).round(2)
    local_daily_sns.update_all(daily_score: grade)
  end

  def set_letter_grade
    grade = case daily_score_converted
    when 90..100
      "A"
    when 75..89
      "B"
    else
      "C"
            end
    daily_sns.each { |sns| sns.update_column(:letter_grade, grade) }
  end
end
