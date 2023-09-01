class Target < ActiveRecord::Base
  belongs_to :evaluation

  scope :newest_first, lambda { order("targets.created_at DESC" )}
  scope :newest_last, lambda { order("targets.created_at ASC" )}
  scope :between, -> (start_date, end_date) { where("created_at > ? AND created_at < ?", start_date, end_date) }

  validates_presence_of :date
  validates_presence_of :description
  validates_presence_of :letter_grade
  validates_presence_of :student_input
  validate :is_evaluation_active, :on => [:create, :update, :edit, :batch_edit]

  def is_evaluation_active
    unless evaluation.is_active?
      errors[:base] << 'The academic profile to which this attendance belongs must be active'
    end
  end
end
