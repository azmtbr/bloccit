class CreateRatings < ActiveRecord::Migration
    def change
      create_table :ratings do |t|
        t.integer :severity
        t.integer :rateable_id
        t.string  :rateable_type

        t.timestamps
    end
    add_index :ratings, :rateable_id
    add_foreign_key :rating, :topics
    add_foreign_key :rating, :posts
  end
end
