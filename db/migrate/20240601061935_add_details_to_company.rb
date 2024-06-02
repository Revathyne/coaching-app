class AddDetailsToCompany < ActiveRecord::Migration[7.1]
  def change
    add_column :companies, :description, :string
    add_column :companies, :phone, :integer
    add_column :companies, :address, :integer
  end
end
