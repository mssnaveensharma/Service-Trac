class AddWorkingHoursToAdminServiceCenters < ActiveRecord::Migration
  def change
    add_column :admin_service_centers, :WorkingHours, :string
  end
end
