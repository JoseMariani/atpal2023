class RemoveDocumentsSentFromStudyperiods < ActiveRecord::Migration
  def change
    remove_column :study_periods, :documents_sent, :string
  end
end
