class AddContactToAdminTechSupports < ActiveRecord::Migration
  def change
    add_column :admin_tech_supports, :Contact, :string
  end
end
