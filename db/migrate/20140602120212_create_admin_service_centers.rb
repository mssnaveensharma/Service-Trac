class CreateAdminServiceCenters < ActiveRecord::Migration
  def change
    create_table :admin_service_centers do |t|
      t.string :Name
      t.string :State
      t.string :City
      t.string :Pin
      t.string :Tel
      t.string :Fax
      t.string :Email
      t.string :Url
      t.string :ContactPerson

      t.timestamps
    end
  end
end
