class DailyController < ApplicationController

  def batch_edit_current_active_student_query
    Student.joins(:study_periods)
      .joins("INNER JOIN evaluations on study_periods.id = evaluations.study_period_id")
      .where("evaluations.is_active is true AND study_periods.course_language = '#{params[:language]}' AND
        students.group = #{Student.groups[params[:group]]} AND lower(students.status) = 'active'").uniq { |s| s.id }
  end
end