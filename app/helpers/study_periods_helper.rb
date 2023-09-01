module StudyPeriodsHelper

  def get_full_or_part_time(study_period)
    return if study_period.nil? or study_period.program.nil?

    if study_period.program.hours.first.number >= 20
      "Full-Time"
    else
      "Part-Time"
    end
  end

  def get_course(study_period)
    return if study_period.nil? or study_period.program.nil?

    if study_period.course_language.downcase == "english" && study_period.program.title.downcase == "summer camp"
      "#{study_period.course_language.capitalize} as a Second Language #{study_period.program.title} Course"
    elsif study_period.course_language.capitalize == "English" && study_period.program.title.downcase == "intensive training"
      "#{study_period.course_language.capitalize} as a Second Language Course"
    else
      "#{study_period.course_language.capitalize} #{study_period.program.title.capitalize} Course"
    end
  end

  def get_program_hours(study_period)
    return if study_period.nil? or study_period.program.nil?

    "(#{study_period.program.hours.first.number} hours/week) in the #{study_period.start_date.strftime("%Y")}"
  end

  def get_name_of_program(study_period)
    return if study_period.nil? or study_period.program.nil?

    if study_period.course_language.downcase == "english" && study_period.program.title.downcase == "summer camp"
      "#{study_period.course_language.capitalize} as a Second Language Summer Camp"
    elsif study_period.course_language.capitalize == "English" && study_period.program.title.downcase == "intensive training"
      "#{study_period.course_language.capitalize} as a Second Language"
    else
      "#{study_period.course_language.capitalize}"
    end
  end

  def get_type_of_program(study_period)
    return if study_period.nil? or study_period.program.nil?

    "#{study_period.course_language.capitalize} #{get_full_or_part_time(study_period)} (#{study_period.program.hours.first.number} hours/week)"
  end

end
