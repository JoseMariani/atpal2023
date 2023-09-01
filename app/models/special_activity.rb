class SpecialActivity < ActiveRecord::Base
  belongs_to :evaluation

  validates_presence_of :date

  scope :newest_first, lambda { order("special_activities.created_at DESC" )}

  validate :is_evaluation_active, :on => [:create, :update, :edit, :delete, :destroy]

  def is_evaluation_active
    unless evaluation.is_active?
      errors[:base] << 'The academic profile to which this attendance belongs must be active'
    end
  end
end
