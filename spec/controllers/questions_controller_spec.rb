require 'rails_helper'
include RandomData

RSpec.describe QuestionsController, type: :controller do

  let (:my_question) { Question.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: true) }


    describe 'GET index' do

      it 'returns http success' do
        get :index
        expect(response).to have_http_status(:success)
      end

      it 'assigns my_question to @question' do
        get :index
        expect(assigns(:questions)).to eq([my_question])
      end

    end



    describe 'GET new' do

      it 'returns http success' do
        get :new
        expect(response).to have_http_status(:success)
      end

      it 'renders the new view' do
         # we expect QuestionsController#new to render the questions new view.
        # We use the render_template method to verify that the correct template (view) is rendered.
        get :new
        expect(response).to render_template :new
      end

      it 'instantiates @question' do
        # we expect the @question instance variable to be initialized by QuestionsController#new.
        # assigns gives us access to the @question variable, assigning it to :question.
        get :new
        expect(assigns(:question)).not_to be_nil
      end

    end



    describe 'Question create' do

      it 'increases the number of Questions by 1' do
        # we expect that after PostsController#create is called with the parameters:
        # {post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}},
        # the count of Post instances (i.e. rows in the posts table) in the database will increase by one.
        expect{post :create, question: {title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: true}}.to change(Question,:count).by(1)
      end

      it 'assigns the new question to @question' do
        # when create is POSTed to, we expect the newly created question to be assigned to @question.
        post :create, question: {title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: true}
        expect(assigns(:question)).to eq Question.last
      end

      it 'redirects to the new question' do
        # we expect to be redirected to the newly created question
        post :create, question: {title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: true}
        expect(response).to redirect_to Question.last
      end
    end



    describe 'GET show' do

      it 'returns http success' do
        # we pass {id: my_question.id} to show as a parameter. These parameters are passed to the params hash.
        get :show, {id: my_question.id}
        expect(response).to have_http_status(:success)
      end

      it 'renders the show view' do
        # we expect the response to return the show view using the render_template matcher
        get :show, {id: my_question.id}
        expect(response).to render_template(:show)
      end

      it 'assigns my_question to @question' do
        # we expect the question to equal my_question because we call show with the id of my_question.
        # We are testing that the post returned to us, is the post we asked for.
        get :show, {id: my_question.id}
        expect(assigns(:question)).to eq(my_question)
      end
    end



    describe 'GET edit' do

      it 'returns http success' do
        get :edit, {id: my_question.id}
        expect(response).to have_http_status(:success)
      end

      it 'renders the #edit view' do
        # we expect the edit view to render when a post is edited.
        get :edit, {id: my_question.id}
        expect(response).to render_template(:edit)
      end

      it 'assigns question to be updated to @question' do
        # we test that edit assigns the correct question to be updated to @question
        get :edit, {id: my_question.id}
        question_instance = assigns(:question)
        expect(question_instance.id).to eq my_question.id
        expect(question_instance.title).to eq my_question.title
        expect(question_instance.body).to eq my_question.body
        expect(question_instance.resolved).to eq my_question.resolved
      end
    end



    describe 'PUT update' do

      it 'updates question with expected attributes' do
        # We test that @question was updated with the title and body passed to update.
        # We also test that @question's id was not changed.

        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        new_resolved = false

        put :update, id: my_question.id, question: {title: new_title, body: new_body, resolved: new_resolved}

        updated_question = assigns(:question)

        expect(updated_question.id).to eq(my_question.id)
        expect(updated_question.title).to eq(new_title)
        expect(updated_question.body).to eq(new_body)
        expect(updated_question.resolved).to eq(new_resolved)

      end

      it 'redirects to the updated question' do
        # we expect we will be redirected to the question show view after the update.
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph
        new_resolved = false

        put :update, id: my_question.id, question: {title: new_title, body: new_body, resolved: new_resolved}
        expect(response).to redirect_to(my_question)
      end
    end



    describe 'DELETE destroy' do

      it 'deletes the question' do
        # we search the database for a question with an id equal to my_question.id. This returns an Array.
        # We assign the size of the array to count, and we expect count to equal zero.
        # This test asserts that the database won't have a matching question after destroy is called.
        delete :destroy, {id: my_question.id}
        count = Question.where({id: my_question.id}).size
        expect(count).to eq(0)
      end

      it 'redirects to questions index' do
        # we expect to be redirected to the questions index view after a question has been deleted.
        delete :destroy, {id: my_question.id}
        expect(response).to redirect_to questions_path
      end
    end
end
