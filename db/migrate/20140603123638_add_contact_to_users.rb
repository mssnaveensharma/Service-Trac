class AddContactToUsers < ActiveRecord::Migration
  def change
    add_column :users, :Contact, :integer
  end
end
