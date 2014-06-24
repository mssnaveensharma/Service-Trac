class AddWpNotificationUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :wp_notification_url, :string
  end
end
