class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :FromUserId, :references => :users
      t.integer :ToUserId, :references => :users
      t.text :MessageContent
      t.timestamps
    end
  end
end
