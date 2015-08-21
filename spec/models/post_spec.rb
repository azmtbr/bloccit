require 'rails_helper'

RSpec.describe Post, type: :model do
  # using the let method, we create a new instance of the Post class, and name it post.
  let(:post) { Post.create!(title: "New Post Title", body: "New Post Body") }

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
