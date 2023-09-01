class Automatization < ActiveRecord::Base
  belongs_to :evaluation

  scope :newest_first, lambda { order("automatizations.created_at DESC" )}

  scope :between, -> (start_date, end_date) { where("created_at > ? AND created_at < ?", start_date, end_date) }

  validate :is_evaluation_active, :on => [:create, :update, :edit, :batch_edit]

  def is_evaluation_active
    unless evaluation.is_active?
      errors[:base] << 'The academic profile to which this attendance belongs must be active'
    end
  end
end
