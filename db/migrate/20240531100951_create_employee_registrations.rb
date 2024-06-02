class CreateEmployeeRegistrations < ActiveRecord::Migration[7.1]
  def change
    create_table :employee_registrations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :coaching_program, null: false, foreign_key: true
      t.references :coach, null: false, foreign_key: true

      t.timestamps
    end
  end
end
