class AddColumnPermalinkToPost < ActiveRecord::Migration
  def change
    add_column :posts, :permalink, :string
    Post.connection.execute("update posts set permalink=replace(title,' ','-')")
  end
end
