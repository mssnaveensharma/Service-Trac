class AddStateCodeToAdminServiceCenters < ActiveRecord::Migration
  def change
    add_column :admin_service_centers, :StateCode, :string
  end
end
