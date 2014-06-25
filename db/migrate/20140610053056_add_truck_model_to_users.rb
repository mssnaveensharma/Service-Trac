class AddTruckModelToUsers < ActiveRecord::Migration
  def change
    add_column :users, :TruckModel, :string
  end
end
