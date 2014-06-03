class AddTruckmakeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :truckmake, :string
  end
end
