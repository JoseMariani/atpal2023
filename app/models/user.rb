class User < ActiveRecord::Base

  enum role: [:visitor, :teacher, :coordinator, :admin, :agent, :marketer]

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :visitor
  end

  has_many :agency_restrictions
  has_many :agencies, :through => :agency_restrictions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  def complete_name
    "#{first_name} #{last_name}"
  end

  scope :not_admin, -> { where.not(role: self.roles[:admin]).order('first_name ASC') }

  scope :marketer, -> { where(role: self.roles[:marketer]).order('first_name ASC') }

  scope :agent_or_marketer, -> { where("role = ? OR role = ?", self.roles[:marketer], self.roles[:agent]).order('first_name ASC') }
end
