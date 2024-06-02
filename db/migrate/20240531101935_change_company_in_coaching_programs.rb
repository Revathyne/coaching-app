class ChangeCompanyInCoachingPrograms < ActiveRecord::Migration[7.1]
  def change
     change_column :users, :company_id, :integer, null: true
  end
end
