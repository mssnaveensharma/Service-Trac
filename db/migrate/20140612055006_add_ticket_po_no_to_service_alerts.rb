class AddTicketPoNoToServiceAlerts < ActiveRecord::Migration
  def change
    add_column :service_alerts, :ticket_po_no, :string
    add_column :service_alerts, :ticket_ref_no, :string
  end
end
