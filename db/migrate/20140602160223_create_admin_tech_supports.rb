class CreateAdminTechSupports < ActiveRecord::Migration
  def change
    create_table :admin_tech_supports do |t|
      t.string :SupportDescription

      t.timestamps
    end
  end
end
