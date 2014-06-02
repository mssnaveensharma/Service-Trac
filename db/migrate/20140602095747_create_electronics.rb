class CreateElectronics < ActiveRecord::Migration
  def change
    create_table :electronics do |t|
      t.integer :s_no
      t.string :make
      t.string :model

      t.timestamps
    end
  end
end
