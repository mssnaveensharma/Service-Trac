class CreateAdminCompanies < ActiveRecord::Migration
  def change
    create_table :admin_companies do |t|
      t.string :CompanyName

      t.timestamps
    end
  end
end
