class CreateServiceCenterReviews < ActiveRecord::Migration
  def change
    create_table :service_center_reviews do |t|
      t.integer :user_id
      t.string :comments
      t.integer :service_center_id
      t.integer :ratings

      t.timestamps
    end
  end
end
