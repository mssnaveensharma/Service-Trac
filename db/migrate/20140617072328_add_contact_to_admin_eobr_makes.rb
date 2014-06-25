class AddContactToAdminEobrMakes < ActiveRecord::Migration
  def change
    add_column :admin_eobr_makes, :Contact, :string
  end
end
