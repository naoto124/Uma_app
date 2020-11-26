Rails.application.routes.draw do
  
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to:'sessions#destroy'
  get "/signup", to:"user#new", as:"singup"
  post"/create",to:"user#create",as:"create"
  get "/index", to:"home#index",as:"race_index"
  get "/index/1", to:"home#show",as:"index_show"
  resources:user

  get '/uma_index',to:'uma#index',as:'uma_index'
  get '/uma_show/:link',to:'uma#show',as:'uma_show'
  get '/uma_detail/:name',to:'uma#detail',as:'uma_detail'
  resources:uma, params: :name

  get '/race_index', to:'race#index', as:'race_index_next'
  get '/race_info/:name', to:'race#info', as:'race_info'
  # get 'race_detail/:name',to:'race#detail',as:'race_detail'
  get '/race_show/:name', to:'race#show', as:'race_show'
  get '/race_run/:name', to:'race#run', as:'race_run'
  resources:race, params: :name

  resources :uma do
    post 'add' => 'favorite#create'
    get '/add' => 'favorite#edit'
    post '/add' =>'favorite#updete'
    delete '/add' => 'favorite#destroy'
  end

  root "home#top"  
end
