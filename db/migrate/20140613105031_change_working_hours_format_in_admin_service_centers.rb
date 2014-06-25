class ChangeWorkingHoursFormatInAdminServiceCenters < ActiveRecord::Migration
  def change
  	change_column :admin_service_centers, :WorkingHours, :text
  end
end
