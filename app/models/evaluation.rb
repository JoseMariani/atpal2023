class Evaluation < ActiveRecord::Base

  enum status: [:current, :old]

  belongs_to :student

  belongs_to :study_period

  has_many :attendances, :dependent => :destroy
  has_many :special_activities, :dependent => :destroy
  has_many :quizzes, :dependent => :destroy
  has_many :targets, :dependent => :destroy
  has_many :tests, :dependent => :destroy
  has_many :digital_tests, :dependent => :destroy
  has_many :sharp_and_smarts, :dependent => :destroy
  has_many :automatizations, :dependent => :destroy

  after_create :set_as_default_if_none_default
  after_save :set_others_as_inactive

  def no_referenced_attendances
    return if attendances.empty?

    errors.add(:base, "this evaluation is referenced by attendances(s): #{attendances.map(&:id).to_sentence}")
    false # If you return anything else, the callback will not stop the destroy from happening
  end

  def no_referenced_special_activities
    return if special_activities.empty?

    errors.add(:base, "this evaluation is referenced by attendances(s): #{special_activities.map(&:id).to_sentence}")
    false # If you return anything else, the callback will not stop the destroy from happening
  end

  def no_referenced_quizzes
    return if quizzes.empty?

    errors.add(:base, "this evaluation is referenced by quiz(zes): #{quizzes.map(&:id).to_sentence}")
    false # If you return anything else, the callback will not stop the destroy from happening
  end

  def no_referenced_targets
    return if targets.empty?

    errors.add(:base, "this evaluation is referenced by target(s): #{targets.map(&:id).to_sentence}")
    false # If you return anything else, the callback will not stop the destroy from happening
  end

  def no_referenced_tests
    return if tests.empty?

    errors.add(:base, "this evaluation is referenced by test(s): #{tests.map(&:id).to_sentence}")
    false # If you return anything else, the callback will not stop the destroy from happening
  end

  def no_referenced_digital_tests
    return if digital_tests.empty?

    errors.add(:base, "this evaluation is referenced by digital test(s): #{digital_tests.map(&:id).to_sentence}")
    false # If you return anything else, the callback will not stop the destroy from happening
  end

  def no_referenced_sharp_and_smart
    return if sharp_and_smarts.empty?

    errors.add(:base, "this evaluation is referenced by sharp and smart(s): #{sharp_and_smarts.map(&:id).to_sentence}")
    false # If you return anything else, the callback will not stop the destroy from happening
  end

  def no_referenced_automatization
    return if automatizations.empty?

    errors.add(:base, "this evaluation is referenced by automatization(s): #{automatizations.map(&:id).to_sentence}")
    false # If you return anything else, the callback will not stop the destroy from happening
  end
  
  def absences_count
    self.attendances.where(:absent => "Absent").count
  end
  
  def overall_grade
    self.attendances.where.not(absent: "Justified Absence").average(:grade)
  end
  
  def target_teacher_eval_week
    grade = 0
    number_of_targets = self.targets.where('created_at >= ?', 1.week.ago).count
    self.targets.where('created_at >= ?', 1.week.ago).each do |target|
      if target.letter_grade == "A"
        grade += 100
      elsif target.letter_grade == "B"
        grade += 80
      elsif target.letter_grade == "C"
        grade += 74
      elsif target.letter_grade.nil?
        number_of_targets -= 1
      end     
    end
    
    if number_of_targets > 0
      if grade / number_of_targets < 76
        return "C" 
      elsif grade / number_of_targets > 75 && grade / number_of_targets < 90
        return "B " 
      elsif grade / number_of_targets > 89
        return "A " 
      end
    else
      return "Not yet determined"
    end
  end
  
  def target_teacher_eval_overall
    grade = 0
    number_of_targets = self.targets.count
    
    self.targets.each do |target|
      if target.letter_grade == "A"
        grade += 100
      elsif target.letter_grade == "B"
        grade += 80
      elsif target.letter_grade == "C"
        grade += 74
      elsif target.letter_grade.nil?
        number_of_targets -= 1
      end
    end
    
    if number_of_targets > 0
      if grade / number_of_targets < 76
        return "C" 
      elsif grade / number_of_targets > 75 && grade / number_of_targets < 90
        return "B " 
      elsif grade / number_of_targets > 89
        return "A " 
      end
    else 
      return "Not yet determined"
    end
  end

  def target_student_input_week
    self.targets.where('created_at >= ?', 1.week.ago).average(:student_input)
  end

  def sharpnsmart_teacher_eval_week
    grade = 0
    number_of_sns = self.sharp_and_smarts.where('created_at >= ?', 1.week.ago).count
    self.sharp_and_smarts.where('created_at >= ?', 1.week.ago).each do |sns|
      if sns.letter_grade == "A"
        grade += 100
      elsif sns.letter_grade == "B"
        grade += 80
      elsif sns.letter_grade == "C"
        grade += 74
      elsif sns.letter_grade.nil?
        number_of_sns = 1
      end
    end

    if number_of_sns > 0
      if grade / number_of_sns < 76
        return "C"
      elsif grade / number_of_sns > 75 && grade / number_of_sns < 90
        return "B "
      elsif grade / number_of_sns > 89
        return "A "
      end
    else
      return "Not yet determined"
    end
  end

  def sharpnsmart_teacher_eval_overall
    grade = 0
    number_of_sns = self.sharp_and_smarts.count

    self.sharp_and_smarts.each do |sns|
      if sns.letter_grade == "A"
        grade += 100
      elsif sns.letter_grade == "B"
        grade += 80
      elsif sns.letter_grade == "C"
        grade += 74
      elsif sns.letter_grade.nil?
        number_of_sns -= 1
      end
    end

    if number_of_sns > 0
      if grade / number_of_sns < 76
        return "C"
      elsif grade / number_of_sns > 75 && grade / number_of_sns < 90
        return "B "
      elsif grade / number_of_sns > 89
        return "A "
      end
    else
      return "Not yet determined"
    end
  end

  def automatizations_teacher_eval_week
    grade = 0
    number_of_automatizations = self.automatizations.where('created_at >= ?', 1.week.ago).count
    self.automatizations.where('created_at >= ?', 1.week.ago).each do |sns|
      if sns.letter_grade == "A"
        grade += 100
      elsif sns.letter_grade == "B"
        grade += 80
      elsif sns.letter_grade == "C"
        grade += 74
      elsif sns.letter_grade.nil?
        number_of_automatizations -= 1
      end
    end

    if number_of_automatizations > 0
      if grade / number_of_automatizations < 76
        return "C"
      elsif grade / number_of_automatizations > 75 && grade / number_of_automatizations < 90
        return "B "
      elsif grade / number_of_automatizations > 89
        return "A "
      end
    else
      return "Not yet determined"
    end
  end

  def automatizations_teacher_eval_overall
    grade = 0
    number_of_automatizations = self.automatizations.count

    self.automatizations.each do |sns|
      if sns.letter_grade == "A"
        grade += 100
      elsif sns.letter_grade == "B"
        grade += 80
      elsif sns.letter_grade == "C"
        grade += 74
      elsif sns.letter_grade.nil?
        number_of_automatizations -= 1
      end
    end

    if number_of_automatizations > 0
      if grade / number_of_automatizations < 76
        return "C"
      elsif grade / number_of_automatizations > 75 && grade / number_of_automatizations < 90
        return "B "
      elsif grade / number_of_automatizations > 89
        return "A "
      end
    else
      return "Not yet determined"
    end
  end
  
  #this are the functions pertaining quizzes
  
  def quiz_average_letter_grade_week
    grade = 0
    number_of_targets = self.quizzes.where('created_at >= ?', 1.week.ago).count
    self.quizzes.where('created_at >= ?', 1.week.ago).each do |quiz|
      if quiz.letter_grade == "A"
        grade += 100
      elsif quiz.letter_grade == "B"
        grade += 80
      elsif quiz.letter_grade == "C"
        grade += 74
      elsif quiz.letter_grade.nil?
        number_of_targets -= 1
      end     
    end
    
    if number_of_targets > 0
      if grade / number_of_targets < 76
        return "C" 
      elsif grade / number_of_targets > 75 && grade / number_of_targets < 90
        return "B " 
      elsif grade / number_of_targets > 89
        return "A " 
      end
    else
      return "Not yet determined"
    end
  end
  
  def quiz_grade_percentage_last_week
    self.quizzes.where('created_at >= ?', 1.week.ago).average(:grade_percentage)
  end
  
  def quiz_grade_percentage_overall
    self.quizzes.average(:grade_percentage)
  end
  
  #this are the functions pertaining tests
  
  def test_average_letter_grade_week
    grade = 0
    number_of_targets = self.tests.where('created_at >= ?', 1.week.ago).count
    self.tests.where('created_at >= ?', 1.week.ago).each do |test|
      if test.letter_grade == "A"
        grade += 100
      elsif test.letter_grade == "B"
        grade += 80
      elsif test.letter_grade == "C"
        grade += 74
      elsif test.letter_grade.nil?
        number_of_targets -= 1
      end     
    end
    
    if number_of_targets > 0
      if grade / number_of_targets < 76
        return "C" 
      elsif grade / number_of_targets > 75 && grade / number_of_targets < 90
        return "B " 
      elsif grade / number_of_targets > 89
        return "A " 
      end
    else
      return "Not yet determined"
    end
  end
  
  def test_grade_percentage_last_week
    self.tests.where('created_at >= ?', 1.week.ago).average(:grade_percentage)
  end
  
  def test_grade_percentage_overall
    self.tests.average(:grade_percentage)
  end
  
  #this are the functions pertaining to special activities
  
  def special_activity_average_letter_grade_week
    grade = 0
    number_of_targets = self.special_activities.where('created_at >= ?', 1.week.ago).count
    self.special_activities.where('created_at >= ?', 1.week.ago).each do |sa|
      if sa.letter_grade == "A"
        grade += 100
      elsif sa.letter_grade == "B"
        grade += 80
      elsif sa.letter_grade == "C"
        grade += 74
      elsif sa.letter_grade.nil?
        number_of_targets -= 1
      end     
    end
    
    if number_of_targets > 0
      if grade / number_of_targets < 76
        return "C" 
      elsif grade / number_of_targets > 75 && grade / number_of_targets < 90
        return "B " 
      elsif grade / number_of_targets > 89
        return "A " 
      end
    else
      return "Not yet determined"
    end
  end
  
  def special_activity_average_letter_grade_bimonthly
    grade = 0
    number_of_targets = self.special_activities.where('created_at >= ?', 2.month.ago).count
    self.special_activities.where('created_at >= ?', 1.week.ago).each do |sa|
      if sa.letter_grade == "A"
        grade += 100
      elsif sa.letter_grade == "B"
        grade += 80
      elsif sa.letter_grade == "C"
        grade += 74
      elsif sa.letter_grade.nil?
        number_of_targets -= 1
      end     
    end
    
    if number_of_targets > 0
      if grade / number_of_targets < 76
        return "C" 
      elsif grade / number_of_targets > 75 && grade / number_of_targets < 90
        return "B " 
      elsif grade / number_of_targets > 89
        return "A " 
      end
    else
      return "Not yet determined"
    end
  end

  def is_current_active
    is_active? ? "Active academic profile" : "inactive"
  end

  private

  def set_as_default_if_none_default
    study_periods = self.study_period.student.study_periods

    has_default_evaluation = false
    study_periods.each do |sp|
      sp.evaluations.each do |eval|
        has_default_evaluation = true if eval.is_active?
      end
    end

    if !has_default_evaluation
      self.update(is_active: true)
    end
  end

  def set_others_as_inactive
    study_periods = self.study_period.student.study_periods

    if self.is_active?
      study_periods.each do |sp|
        sp.evaluations.reject{ |eval| eval.id == self.id }.each do |eval|
          eval.update(is_active: false)
        end
      end
    end
  end
  
end
