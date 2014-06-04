class AddLanToAdminServiceCenters < ActiveRecord::Migration
  def change
    add_column :admin_service_centers, :lan, :string
  end
end
