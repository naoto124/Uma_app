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

  root "home#top"  
end
