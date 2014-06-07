class AddUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :Url, :string
  end
end
