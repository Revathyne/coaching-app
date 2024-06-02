class CreateJoinTableCoachesCoachingPrograms < ActiveRecord::Migration[6.1]
  def change
    create_join_table :coaches, :coaching_programs
  end
end
