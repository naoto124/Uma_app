Rails.application.routes.draw do
  
  # get 'uma/index'

  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to:'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get "/signup", to:"user#new", as:"singup"
  post"/create",to:"user#create",as:"create"


  get "/index", to:"home#index",as:"race_index"
  get "/index/1", to:"home#show",as:"index_show"
  # get"/post/from/race_id",to:"post#show",as:"index_show"

  get '/uma_index',to:'uma#index',as:'uma_index'

  root "home#top"  
end
