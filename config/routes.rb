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
  get '/uma_show/uma_detail/:name',to:'uma#detail',as:'uma_detail'
  resources:uma, params: :name

  get '/race_index', to:'race#index', as:'race_next'
  get '/race_index/:name', to:'race#info', as:'race_info'
  get '/uma_show/uma_detail/race_show/:name', to:'race#show', as:'race_show'
  resources:race, params: :name


  root "home#top"  
end
