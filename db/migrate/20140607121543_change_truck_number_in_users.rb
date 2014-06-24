class ChangeTruckNumberInUsers < ActiveRecord::Migration
  def change
  	change_column :users, :TruckNumber, :string
  end
end
