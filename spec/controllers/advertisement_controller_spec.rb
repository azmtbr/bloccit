require 'rails_helper'
include RandomData

RSpec.describe AdvertisementController, type: :controller do

 let (:my_ad) { Advertisement.create!(title: RandomData.random_sentence, copy: RandomData.random_paragraph, price: 1,000,000) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns my_ad to @advertisement' do
        get :index
        expect(assigns(:advertisements)).to eq([my_ad])
      end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end

    it 'renders the show view' do
      # we expect the response to return the show view using the render_template matcher
      get :show, {id: my_ad.id}
      expect(response).to render_template(:show)
    end

    it 'assigns my_ad to @advertisement' do
      # we expect the advertisement to equal my_ad because we call show with the id of my_ad.
      # We are testing that the advertisement returned to us, is the advertisement we asked for.
      get :show, {id: my_ad.id}
      expect(assigns(:advertisement)).to eq(my_ad)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

  #we expect the @advertisement instance variable to be initialized by AdvertisementController#new.
  #assigns gives us access to the @advertisement variable, assigning it to :post.
    it "instantiates @advertisement" do
      get :new
      expect(assigns(:advertisement)).not_to be_nil
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

end
