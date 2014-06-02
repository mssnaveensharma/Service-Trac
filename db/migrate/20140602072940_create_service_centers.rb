class CreateServiceCenters < ActiveRecord::Migration
  def change
    create_table :service_centers do |t|
      t.string :name
      t.string :city
      t.string :state
      t.integer :pin
      t.integer :telephone
      t.integer :fax
      t.string :email
      t.string :url
      t.string :contact_person

      t.timestamps
    end
  end
end
