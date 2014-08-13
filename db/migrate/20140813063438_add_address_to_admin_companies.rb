class AddAddressToAdminCompanies < ActiveRecord::Migration
  def change
    add_column :admin_companies, :Address, :string
    add_column :admin_companies, :Address2, :string
    add_column :admin_companies, :City, :string
    add_column :admin_companies, :State, :string
    add_column :admin_companies, :Zip, :integer
    add_column :admin_companies, :Telephone, :integer
    add_column :admin_companies, :Fax, :integer
    add_column :admin_companies, :Email, :string
    add_column :admin_companies, :ContactName, :string
  end
end
