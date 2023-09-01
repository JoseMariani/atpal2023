class FixedDurationProgram < ActiveRecord::Base

  validates_presence_of :name
  
  has_many :fixed_duration_pro_statements
  has_many :statements, :through => :fixed_duration_pro_statements
  has_many :fixed_duration_pro_students
  has_many :students, :through => :fixed_duration_pro_students

  has_many :study_period_fixed_programs
  has_many :study_periods, :through => :study_period_fixed_programs

  has_and_belongs_to_many :promos

  def no_referenced_students
    return if students.empty?

    errors.add(:base, "this program is referenced by student(s): #{students.map(&:id).to_sentence}")
    false # If you return anything else, the callback will not stop the destroy from happening
  end

  def combined_value
    if !self.promos.empty?
      price_after_promo
      "#{self.name} | Price: $#{self.cost} | After Promos: $#{self.total_after_promos}"
    else
      "#{self.name} | Price: $#{self.cost} | After Promos: $#{self.cost}"
    end
  end

  def price_after_promo
    if self.promos != nil
      total = self.cost
      self.promos.each do |promo|
        total = total* (1 - promo.number)
      end
      self.total_after_promos = total
    else
      " Total: $#{self.cost}"
    end
    "#{self.name} | Price: $#{self.cost}"
  end

  def price_after_promotions
    if self.promos != nil
      total = self.cost
      self.promos.each do |promo|
        total = total* (1 - promo.number)
      end
      self.total_after_promos = total
      return total_after_promos
    else
      return self.cost
    end
  end

end
