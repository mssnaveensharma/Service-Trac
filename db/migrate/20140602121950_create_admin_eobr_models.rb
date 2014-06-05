class CreateAdminEobrModels < ActiveRecord::Migration
  def change
    create_table :admin_eobr_models do |t|
      t.string :Name
      t.references :EobrMake, index: true

      t.timestamps
    end
  end
end
