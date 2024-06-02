class CreateCoachCoachingPrograms < ActiveRecord::Migration[7.1]
  def change
    create_table :coach_coaching_programs do |t|
      t.references :coach, null: false, foreign_key: true
      t.references :coaching_program, null: false, foreign_key: true
      t.string :additional_field

      t.timestamps
    end
  end
end
