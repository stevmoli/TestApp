TestApp::Application.routes.draw do
  get "log_in" => "sessions#new", as: "log_in"
  get "log_out" => "sessions#destroy", as: "log_out"

  get "users/sign_up" => "users#new", as: "sign_up"

  get "welcome/index"

  resources :users, :posts, :sessions


  root :to => 'welcome#index'

  get '/all' => redirect('/posts')
  delete "posts/:id" => 'posts#destroy'

  #get "/user_posts/:user" => "posts#index", :as => "user_posts"


  get '/users/:id' => "user#show", as: "user_page"
  get '/user_posts/:id' => redirect('/users/:id')
  #get ':user' => 'posts#index', as: 'user_posts'
end
