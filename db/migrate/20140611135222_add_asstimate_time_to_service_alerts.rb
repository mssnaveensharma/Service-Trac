class AddAsstimateTimeToServiceAlerts < ActiveRecord::Migration
  def change
    add_column :service_alerts, :asstimate_time, :string
    add_column :service_alerts, :asstimate_date, :string
  end
end
