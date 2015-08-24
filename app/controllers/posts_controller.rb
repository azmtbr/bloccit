class PostsController < ApplicationController

  def index
  #declare an instance variable @posts and assign it a collection of Post objects using the all method, provided by ActiveRecord.
  #all returns a collection of Post objects.
  @posts = Post.all
  @posts.each_with_index do |post, index| 
  if index % 5 == 4 # since index starts at 0, every 5th object will be at positions 4, 9, 14, 19 etc.
    # Do the change on post object
    post.update_attributes(title: 'CENSORED')
  end
end
  end

  def show
  end

  def new
  end

  def edit
  end
end
