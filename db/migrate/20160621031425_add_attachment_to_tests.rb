class AddAttachmentToTests < ActiveRecord::Migration
  def change
    add_column :tests, :attachment, :string
  end
end
