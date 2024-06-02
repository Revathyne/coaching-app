class EmployeeRegistration < ApplicationRecord
  belongs_to :user
  belongs_to :coaching_program
  belongs_to :coach

  validates :user_id, uniqueness: { scope: %i[coaching_program_id coach_id], message: I18n.t(:registered) }
end
