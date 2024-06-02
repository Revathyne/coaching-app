class Coach < ApplicationRecord
  has_many :employee_registrations, dependent: :destroy
  belongs_to :user
  has_and_belongs_to_many :coaching_programs, join_table: :coach_coaching_programs

  def display_name
    user.name
  end
end
