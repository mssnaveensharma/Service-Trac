class AddStreetAddressToAdminServiceCenters < ActiveRecord::Migration
  def change
    add_column :admin_service_centers, :StreetAddress, :string
  end
end
