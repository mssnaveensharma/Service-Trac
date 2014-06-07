class AddLatToServiceAlerts < ActiveRecord::Migration
  def change
    add_column :service_alerts, :lat, :string
  end
end
