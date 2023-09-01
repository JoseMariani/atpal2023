class DigitalTest < ActiveRecord::Base

  mount_uploader :attachment, AttachmentUploader
  belongs_to :evaluation

  validates_presence_of :level
end
