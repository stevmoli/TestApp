TestApp::Application.routes.draw do
  get "log_in" => "sessions#new", as: "log_in"
  get "log_out" => "sessions#destroy", as: "log_out"

  get "users/sign_up" => "users#new", as: "sign_up"

  get "welcome/index"

  resources :users, :sessions
  resources :posts do
    resources :comments
  end


  root :to => 'welcome#index'

  get '/all' => redirect('/posts')
  delete "posts/:id" => 'posts#destroy'



  get '/users/:id' => "user#show", as: "user_page"
  get '/user_posts/:id' => redirect('/users/:id')

  #get '/posts/:id/comments/:id' => redirect('/posts/:id')
  #delete "/post/:post_id/comments/:id" => "comments#destroy"
  #get "/post/:post_id/comments/:id" => "user#show"
  
end
