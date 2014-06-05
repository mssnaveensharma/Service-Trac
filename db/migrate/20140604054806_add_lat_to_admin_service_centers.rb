class AddLatToAdminServiceCenters < ActiveRecord::Migration
  def change
    add_column :admin_service_centers, :lat, :string
  end
end
