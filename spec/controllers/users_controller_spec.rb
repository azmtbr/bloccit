require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  #create a hash of attributes named new_user_attributes to use in our specs so we can use them easily throughout our spec.
  let (:new_user_attributes) do
    {
      name: "Blochead",
        email: "blochead@bloc.io",
        password: "blochead",
        password_confirmation: "blochead"
    }
  end

  #test the new action for HTTP success when issuing a GET.
  #The first test expects the response to return an HTTP response code of 200.
  #The second test expects new to instantiate a new user.
  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "instantiates a new user" do
      get :new
      expect(:user).to_not be_nil
    end
  end

  describe "POST create" do
     it "returns http success" do
       post :create, user: new_user_attributes
       expect(response).to have_http_status(:redirect)
     end

    it "creates a new user" do

       expect{
         post :create, user: {name: "Blocy", email: "jon@example.com", password: "password", password_confirmation: "password"}
       }.to change(User,:count).by(1)
     end

    it "sets user name properly" do
       post :create, user: new_user_attributes
       expect(assigns(:user).name).to eq new_user_attributes[:name]
     end

    it "sets user email properly" do
       post :create, user: new_user_attributes
       expect(assigns(:user).email).to eq new_user_attributes[:email]
     end

    it "sets user password properly" do
       post :create, user: new_user_attributes
       expect(assigns(:user).password).to eq new_user_attributes[:password]
     end

    it "sets user password_confirmation properly" do
       post :create, user: new_user_attributes
       expect(assigns(:user).password_confirmation).to eq new_user_attributes[:password_confirmation]
     end

    it "logs the user in after sign up" do
      post :create, user: new_user_attributes
      expect(session[:user_id]).to eq assigns(:user).id
    end
  end

  describe "POST confirm" do
    it "returns http success" do
       post :create, user: new_user_attributes
       expect(response).to have_http_status(:success)
     end
   end
end
