class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title

      t.timestamps
    end
    Post.create({:title=>'abc dsd sdsd'})
  end
end