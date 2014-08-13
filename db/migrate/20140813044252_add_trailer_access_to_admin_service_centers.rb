class AddTrailerAccessToAdminServiceCenters < ActiveRecord::Migration
  def change
    add_column :admin_service_centers, :trailer_access, :integer
    add_column :admin_service_centers, :appointment_service, :integer
    add_column :admin_service_centers, :appointment_installation, :integer
  end
end
