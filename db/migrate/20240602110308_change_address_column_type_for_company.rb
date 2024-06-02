class ChangeAddressColumnTypeForCompany < ActiveRecord::Migration[6.1]
  def change
    remove_column :companies, :address, :integer
    add_column :companies, :address, :string
  end
end
