class CreateServiceAlerts < ActiveRecord::Migration
  def change
    create_table :service_alerts do |t|
      t.integer :user_id
      t.integer :service_center_id
      t.string :status

      t.timestamps
    end
  end
end
