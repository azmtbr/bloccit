require 'rails_helper'
include RandomData

RSpec.describe Post, type: :model do
  let(:topic) { create(:topic) }
  let(:user) { create(:user) }
  let(:post) { create(:post) }


  it {should have_many(:labelings) }
  it {should have_many(:labels).through(:labelings) }

  it { should have_many(:comments) }
  it { should have_many(:votes) }
  it { should have_many(:favorites) }
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

     describe "#auto_upvote" do
       it "automatically upvotes a new post" do
         post.auto_upvote
         expect( post.up_votes ).to eq(1)
       end
     end
   end

   describe "after_create" do
      before do
        @another_post = Post.new(body: 'New Post Body', topic: topic, user: user)
      end

      it "sends an email to the user who created the post" do
        post = user.post.create(post: post)
        expect(FavoriteMailer).to receive(:new_post).with(user, @another_post).and_return(double(deliver_now: true))

        @another_post.save
      end

      it "does not send emails to users who didn't create the post" do
        expect(FavoriteMailer).not_to receive(:new_post)

        @another_post.save
      end
    end
end
