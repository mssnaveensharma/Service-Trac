class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :service_alerts, :status, :lat
  end
end
