class AddCertificatePictureToStudyPeriods < ActiveRecord::Migration
  def change
    add_column :study_periods, :certificate_picture, :string
  end
end
