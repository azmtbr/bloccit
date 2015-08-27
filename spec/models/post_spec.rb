require 'rails_helper'
include RandomData

RSpec.describe Post, type: :model do
  #create a parent topic for post.
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}
  #associate post with topic with topic.posts.create!. This is a chained method call which creates a post for a given topic.
  let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph)}

  it {should belong_to(:topic)}

   context "attributes" do
     #test whether post has an attribute named title. This tests whether post will return a non-nil value when post.title is called.
     it "should respond to title" do
       expect(post).to respond_to(:title)
     end
     #apply a similar test to body.
     it "should respond to body" do
       expect(post).to respond_to(:body)
     end
  end
end
