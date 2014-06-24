class ChangeColumnName < ActiveRecord::Migration
  def change
	rename_column :users_service_centers, :service_center_id, :company_id
  end
end
