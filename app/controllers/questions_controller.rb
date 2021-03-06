class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new
    @question.title = params[:question][:title]
    @question.body = params[:question][:body]
    @question.resolved = params[:question][:resolved]

    if @question.save
      flash[:notice] = 'Question saved successfully'
      redirect_to @question
    else
      flash[:error] = 'Question could not be saved, please try again'
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.title = params[:question][:title]
    @question.body = params[:question][:body]
    @question.resolved = params[:question][:resolved]

    if @question.save
      flash[:notice] = 'Question successfully updated'
      redirect_to @question
    else
      flash[:error] = 'Question could not be updated, please try again'
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])

    if @question.destroy
      flash[:notice] = 'Question successfully updated'
      redirect_to questions_path
    else
      flash[:error] = 'Question could not be deleted, please try again'
      render :show
    end
  end
end
