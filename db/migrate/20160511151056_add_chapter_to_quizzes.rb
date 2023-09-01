class AddChapterToQuizzes < ActiveRecord::Migration
  def change
    rename_column :quizzes, :level, :chapter
  end
end
