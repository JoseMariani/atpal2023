class Test < ActiveRecord::Base
  belongs_to :evaluation
  mount_uploader :attachment, AttachmentUploader
  
  scope :newest_first, lambda { order("tests.created_at DESC" )}

  validate :is_evaluation_active, :on => [:create, :update, :edit, :delete, :destroy]

  def is_evaluation_active
    unless evaluation.is_active?
      errors[:base] << 'The academic profile to which this attendance belongs must be active'
    end
  end
end
