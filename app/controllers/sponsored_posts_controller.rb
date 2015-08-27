class SponsoredPostsController < ApplicationController
  before_action :set_topic

  def show
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  def new
    @sponsored_post = SponsoredPost.new
  end

  def create
    @sponsored_post = SponsoredPost.new
    @sponsored_post.title = params[:sponsored_post][:title]
    @sponsored_post.body = params[:sponsored_post][:body]

    @sponsored_post.topic = @topic

    if @sponsored_post.save
      flash[:notice] = 'Sponsored Post was saved.'
      redirect_to [@topic, @sponsored_post]
    else
      flash[:error] = 'There was an error saving the sponsored post. Please try again.'
      render :new
    end
  end

  def edit
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  def update
    @sponsored_post = SponsoredPost.find(params[:id])
    @sponsored_post.title = params[:sponsored_post][:title]
    @sponsored_post.body = params[:sponsored_post][:body]

    if @sponsored_post.save
      flash[:notice] = 'Sponsored Post was updated.'
      redirect_to [@sponsored_post.topic, @sponsored_post]
    else
      flash[:error] = 'There was an error saving the sponsored post. Please try again.'
      render :edit
    end
  end

  def destroy
    @sponsored_post = SponsoredPost.find(params[:id])

    if @sponsored_post.destroy
      flash[:notice] = 'Sponsored Post was deleted.'
      redirect_to @sponsored_post.topic
    else
      flash[:error] = 'There was an error saving the sponsored post. Please try again.'
      render :show
    end
  end

  private

  def set_topic
      @topic = Topic.find(params[:topic_id])
  end
end
