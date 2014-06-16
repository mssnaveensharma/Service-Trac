class CreateAlertNotes < ActiveRecord::Migration
  def change
    create_table :alert_notes do |t|
      t.integer :user_id
      t.integer :alert_id
      t.string :description
      t.string :sent_by

      t.timestamps
    end
  end
end
