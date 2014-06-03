class AddTechSupportToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tech_support, :string
  end
end
