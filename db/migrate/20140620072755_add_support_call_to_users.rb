class AddSupportCallToUsers < ActiveRecord::Migration
  def change
    add_column :users, :support_call, :integer
  end
end
