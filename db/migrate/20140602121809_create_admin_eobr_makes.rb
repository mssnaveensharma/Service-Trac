class CreateAdminEobrMakes < ActiveRecord::Migration
  def change
    create_table :admin_eobr_makes do |t|
      t.string :Name

      t.timestamps
    end
  end
end
