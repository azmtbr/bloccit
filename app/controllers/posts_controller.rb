

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
    #find the post that corresponds to the id in the params that was passed to show and assign it to @post.
    @post = Post.find(params[:id])
  end

  def new
    #create an instance variable, @post, then assign it an empty post returned by Post.new.
    @post = Post.new
  end

  def create
  #call Post.new to create a new instance of Post.
     @post = Post.new
     @post.title = params[:post][:title]
     @post.body = params[:post][:body]

  # if saving the instance of post to the database was successful, we display a success message using flash[:notice] and redirect the user to the route generated by @post.
  #Redirecting to @post will direct the user to the posts show view.
     if @post.save
  #assign a value to flash[:notice]. The flash hash provides a way to pass temporary values between actions.
  #Any value placed in flash will be available in next action and then deleted.
        flash[:notice] = "Post was saved."
        redirect_to @post
     else
  #if saving the instance of post was not successful, we display an error message and render the new view again.
        flash[:error] = "There was an error saving the post. Please try again."
        render :new
     end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
     @post = Post.find(params[:id])
     @post.title = params[:post][:title]
     @post.body = params[:post][:body]

     if @post.save
       flash[:notice] = "Post was updated."
       redirect_to @post
     else
       flash[:error] = "There was an error saving the post. Please try again."
       render :edit
     end
   end

   def destroy
     @post = Post.find(params[:id])

     #call destroy on @post. If that call is successful, we set a flash message and redirect the user to the posts index view.
     #If destroy fails then we redirect the user to the show view using render :show.
     if @post.destroy
       flash[:notice] = "\"#{@post.title}\" was deleted successfully."
       redirect_to posts_path
     else
       flash[:error] = "There was an error deleting the post."
       render :show
     end
   end
end
