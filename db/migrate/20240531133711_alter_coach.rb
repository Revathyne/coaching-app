class AlterCoach < ActiveRecord::Migration[7.1]
  def change
    add_reference :coaches, :user, foreign_key: true
    remove_column :coaches, :name, :string
    remove_column :coaches, :email, :string
  end
end
