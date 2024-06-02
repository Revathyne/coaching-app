class AddCoachRefToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :coach, foreign_key: true
  end
end
