class Quiz < ActiveRecord::Base
  belongs_to :evaluation
  
  scope :newest_first, lambda { order("quizzes.created_at DESC" )}

  validate :is_evaluation_active, :on => [:create, :update, :edit, :delete, :destroy]

  def is_evaluation_active
    unless evaluation.is_active?
      errors[:base] << 'The academic profile to which this attendance belongs must be active'
    end
  end
end
