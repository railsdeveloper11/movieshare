class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :description
      t.integer :rating
      t.integer :movie_id
      t.integer :user_id
      t.timestamps
    end
  end
end
