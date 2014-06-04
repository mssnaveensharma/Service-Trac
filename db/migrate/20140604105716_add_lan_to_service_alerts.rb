class AddLanToServiceAlerts < ActiveRecord::Migration
  def change
    add_column :service_alerts, :lan, :string
  end
end
