require 'rails_helper'
include RandomData

RSpec.describe SponsoredPostsController, type: :controller do

  let (:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}
  let (:my_post) { my_topic.sponsored_posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 1000)}


  describe "GET #show" do
    it "returns http success" do
      get :show, topic_id: my_topic.id, id: my_post.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, topic_id: my_topic.id, id: my_post.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, topic_id: my_topic.id, id: my_post.id
      expect(response).to have_http_status(:success)
    end
  end

end
