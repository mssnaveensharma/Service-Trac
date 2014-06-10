class ChangeContactFormatInMyUsers < ActiveRecord::Migration
  def change
  	change_column :users, :Contact, :string
  end
end
