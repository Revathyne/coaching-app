class User < ApplicationRecord
  after_save :create_coach

  enum role: [:employee, :coach, :admin]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :employee_registrations, dependent: :destroy
  has_many :coaching_programs, through: :employee_registrations, dependent: :destroy
  belongs_to :company, optional: true
  has_one :coach, dependent: :destroy

  validates :name, :email, presence: true

  private

  def create_coach
    return unless role == 'coach'

    Coach.create!(user_id: User.last.id)
  end
end
