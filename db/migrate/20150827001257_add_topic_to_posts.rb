class AddTopicToPosts < ActiveRecord::Migration
  def change
    #the name we gave the migration, AddTopicToPosts, is very important.
    add_column :posts, :topic_id, :integer
    #we created an index on topic_id with the generator. An index improves the speed of operations on a database table.
    add_index :posts, :topic_id
  end
end
