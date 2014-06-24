class CreateUsersServiceCenters < ActiveRecord::Migration
  def change
    create_table :users_service_centers do |t|
      t.integer :user_id
      t.integer :service_center_id
      t.string :status

      t.timestamps
    end
  end
end
