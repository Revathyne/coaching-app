class AddUniqueIndexToEmployeeRegistrations < ActiveRecord::Migration[7.1]
  def change
    add_index :employee_registrations, [:user_id, :coaching_program_id, :coach_id], unique: true, name: 'unique_employee_registration'
  end
end
