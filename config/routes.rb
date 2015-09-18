Rails.application.routes.draw do


  get 'ratings/show'

  #call the resources method, and pass it a Symbol.
  #This instructs Rails to create post routes for creating, updating, viewing, and deleting instances of Post.
  resources :topics do
    resources :posts, except: [:index]
    resources :sponsored_posts, except: [:index]
  end

  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]

    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]

  resources :advertisements
  resources :questions

  resources :labels, only: [:show]



  #remove get "welcome/index" because we've declared the index view as the root view.
  #We also modify the about route to allow users to type /about, rather than /welcome/about.
  post 'users/confirm' => 'users#confirm'

  get 'about' => 'welcome#about'

  get 'faq' => 'welcome#faq'

  root to: 'welcome#index'

end
