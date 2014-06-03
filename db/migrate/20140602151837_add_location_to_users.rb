class AddLocationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lat, :string
    add_column :users, :lan, :string
  end
end
