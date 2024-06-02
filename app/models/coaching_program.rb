class CoachingProgram < ApplicationRecord
  belongs_to :company
  has_many :employee_registrations, dependent: :destroy
  has_many :users, through: :employee_registrations
  has_and_belongs_to_many :coaches, join_table: :coach_coaching_programs

  validates :name, presence: true
end
