class AddServiceCenterIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :service_center_id, :integer
  end
end
