Rails.application.routes.draw do






  #call the resources method, and pass it a Symbol.
  #This instructs Rails to create post routes for creating, updating, viewing, and deleting instances of Post.
  resources :topics do
    resources :posts, except: [:index]
    resources :sponsored_posts, except: [:index]
  end

  resources :advertisements
  resources :questions



  #remove get "welcome/index" because we've declared the index view as the root view.
  #We also modify the about route to allow users to type /about, rather than /welcome/about.

  get 'about' => 'welcome#about'

  root to: 'welcome#index'

end
