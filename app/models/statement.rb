class Statement < ActiveRecord::Base
  belongs_to :student

  belongs_to :study_period
  belongs_to :insurance

  after_save :update_student_and_period

  belongs_to :program
  belongs_to :fixed_duration_program
  belongs_to :accommodation
  belongs_to :adulthood
  belongs_to :region
  belongs_to :agency
  has_many :statement_items, :dependent => :destroy
  has_many :items, through: :statement_items, :dependent => :destroy
  has_many :payments, dependent: :destroy
  has_many :fixed_duration_pro_statements, :dependent => :destroy
  has_many :fixed_duration_programs, :through => :fixed_duration_pro_statements
  has_and_belongs_to_many :promos
  accepts_nested_attributes_for :items, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :statement_items, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :payments, allow_destroy: true, :reject_if => :all_blank
  accepts_nested_attributes_for :promos, :reject_if => :all_blank, allow_destroy: true
  accepts_nested_attributes_for :fixed_duration_programs, :reject_if => :all_blank, allow_destroy: true
  accepts_nested_attributes_for :fixed_duration_pro_statements, :reject_if => :all_blank, allow_destroy: true

  def destroy_statement
    self.destroy
  end

  def update_student_and_period
    if self.update_student?
      student.update_attr(self)
      study_period.update_attr(self)
    end
  end

  def self.new_params(student)
    student_attributes = student.attributes
    study_period_attributes = student.study_periods.last.attributes
    merged_attributes = student_attributes.merge study_period_attributes
    merged_attributes = merged_attributes.except("id")
    merged_attributes = merged_attributes.slice(*Quote.attribute_names)
    merged_attributes = merged_attributes.merge(items: student.study_periods.last.items)
    merged_attributes = merged_attributes.merge(fixed_duration_programs: student.study_periods.last.fixed_duration_programs)
    merged_attributes = merged_attributes.merge(promos: student.study_periods.last.promos)
    merged_attributes
  end

end
