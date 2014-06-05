class AddStatusToServiceAlerts < ActiveRecord::Migration
  def change
    add_column :service_alerts, :Status, :string
  end
end
