class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :e_no
      t.string :e_make
      t.string :e_model
      t.integer :truck_number
      t.string :truck_make
      t.date :truck_year
      t.integer :truck_owner
      t.string :company_name
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :language
      t.string :role

      t.timestamps
    end
  end
end
