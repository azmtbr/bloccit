require 'rails_helper'
include RandomData

RSpec.describe Post, type: :model do
  #create a parent topic for post.
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}
  #create a user to associate with a test post.
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld")}
  #associate post with topic with topic.posts.create!. This is a chained method call which creates a post for a given topic. associate user with post when we create the test post.
  let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)}

  it {should have_many(:labelings) }
  it {should have_many(:labels).through(:labelings) }

  it { should have_many(:comments) }
  it { should have_many(:votes) }
  it { should belong_to(:topic) }
  it { should belong_to(:user) }

  #test that Post validates the presence of title, body, and topic.
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:topic) }
  #test that Post validates the lengths of title and body.
  it { should validate_length_of(:title).is_at_least(5) }
  it { should validate_length_of(:body).is_at_least(20) }


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

   describe "voting" do
     before do
       3.times { post.votes.create!(value: 1) }
       2.times { post.votes.create!(value: -1) }
     end

     describe "#up_votes" do
       it "counts the number of votes with value = 1" do
         expect( post.up_votes ).to eq(3)
       end
     end

     describe "#down_votes" do
       it "counts the number of votes with value = -1" do
         expect( post.down_votes ).to eq(2)
       end
     end

     describe "#points" do
       it "returns the sum of all down and up votes" do
         expect( post.points ).to eq(1) # 3 - 2
       end
     end

     describe "#update_rank" do
       it "calculates the correct rank" do
         post.update_rank
         expect(post.rank).to eq (post.points + (post.created_at - Time.new(1970,1,1)) / 1.day.seconds)
       end

       it "updates the rank when an up vote is created" do
         old_rank = post.rank
         post.votes.create!(value: 1)
         expect(post.rank).to eq (old_rank + 1)
       end

       it "updates the rank when a down vote is created" do
         old_rank = post.rank
         post.votes.create!(value: -1)
         expect(post.rank).to eq (old_rank - 1)
       end
     end
   end
end
