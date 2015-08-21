require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { Question.create!(title: "New Post Title", body: "New Post Body", resolved: "true") }

   context "attributes" do

     #test whether post has an attribute named title. This tests whether post will return a non-nil value when post.title is called.
     it "should respond to title" do
       expect(question).to respond_to(:title)
     end
     #apply a similar test to body.
     it "should respond to body" do
       expect(question).to respond_to(:body)
     end

     it "should respond to resolved" do
       expect(question).to respond_to(:resolved)
     end
  end
end
