class AddDetailsToEmployeeRegistration < ActiveRecord::Migration[7.1]
  def change
    add_column :employee_registrations, :phone, :integer
    add_column :employee_registrations, :address, :integer
  end
end
