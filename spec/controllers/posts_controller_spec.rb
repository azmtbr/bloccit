require 'rails_helper'
include RandomData

RSpec.describe PostsController, type: :controller do

  #create a post and assign it to my_post using let. We use RandomData to give my_post a random title and body.
  let (:my_post) { Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph)}

  #new is invoked, a new and unsaved Post object is created.
  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end


  #we expect PostsController#new to render the posts new view.
  #We use the render_template method to verify that the correct template (view) is rendered.
    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

  #we expect the @post instance variable to be initialized by PostsController#new.
  #assigns gives us access to the @post variable, assigning it to :post.
    it "instantiates @post" do
      get :new
      expect(assigns(:post)).not_to be_nil
    end
  end

  describe "POST create" do
  #When create is invoked, the newly created object is persisted to the database.
    it "increases the number of Post by 1" do
      expect{post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post,:count).by(1)
    end

  #when create is POSTed to, we expect the newly created post to be assigned to @post.
    it "assigns the new post to @post" do
      post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(assigns(:post)).to eq Post.last
    end

  #we expect to be redirected to the newly created post.
    it "redirects to the new post" do
      post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(response).to redirect_to Post.last
    end
  end



  describe "GET show" do
    it "returns http success" do
      #pass {id: my_post.id} to show as a parameter. These parameters are passed to the params hash.
      get :show, {id: my_post.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      #we expect the response to return the show view using the render_template matcher.
      get :show, {id: my_post.id}
      expect(response).to render_template :show
    end

    it "assigns my_post to @post" do
      get :show, {id: my_post.id}
      #we expect the post to equal my_post because we call show with the id of my_post.
      #We are testing that the post returned to us, is the post we asked for.
      expect(assigns(:post)).to eq(my_post)
    end
  end
end



  #describe "GET #new" do
    #it "returns http success" do
      #get :new
      #expect(response).to have_http_status(:success)
    #end
  #end

  #describe "GET #edit" do
    #it "returns http success" do
      #get :edit
      #expect(response).to have_http_status(:success)
    #end
  #end
