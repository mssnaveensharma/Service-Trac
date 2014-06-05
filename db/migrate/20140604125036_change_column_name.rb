class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :service_alerts, :Status, :status
  end
end
