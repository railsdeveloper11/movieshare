class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :movie_url
      t.string :title
      t.timestamps
    end
  end
end
