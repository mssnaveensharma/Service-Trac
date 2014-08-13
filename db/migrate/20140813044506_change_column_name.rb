class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :admin_service_centers, :StateCode, :StreetAddress2
  end
end
