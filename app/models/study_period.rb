class StudyPeriod < ActiveRecord::Base
  belongs_to :program
  belongs_to :accommodation
  belongs_to :adulthood
  belongs_to :student
  belongs_to :insurance

  has_many :study_period_items, :dependent => :destroy
  has_many :items, through: :study_period_items
  has_many :study_period_fixed_programs, :dependent => :destroy
  has_many :fixed_duration_programs, :through => :study_period_fixed_programs

  has_many :statements, dependent: :destroy
  has_many :quotes, dependent: :destroy
  has_many :pro_formas, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :evaluations, dependent: :destroy

  has_and_belongs_to_many :promos

  accepts_nested_attributes_for :fixed_duration_programs
  accepts_nested_attributes_for :study_period_fixed_programs
  accepts_nested_attributes_for :payments, allow_destroy: true, :reject_if => :all_blank
  accepts_nested_attributes_for :promos, :reject_if => :all_blank, allow_destroy: true

  mount_uploader :certificate_picture, CertificatePictureUploader

  def update_attr(ogi)
    attr = ogi.attributes.slice(*self.attribute_names).except("id")
    attr = attr.merge(items: ogi.items)
    attr = attr.merge(fixed_duration_programs: ogi.fixed_duration_programs)
    attr = attr.merge(promos: ogi.promos)
    self.update_attributes(attr)
  end

  def update_balance(ogi)
    self.update_attributes(:balance => ogi.balance)
  end

  def latest?
    self.student.most_current_study_period == self
  end

  def has_associations
    items.any? || fixed_duration_programs.any? || statements.any? || quotes.any? ||
      pro_formas.any? || invoices.any? || payments.any? || evaluations.any?
  end
end
