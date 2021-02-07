Rails.application.routes.draw do

  root "home#top" 

  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to:'sessions#destroy'
  get "/signup", to:"user#new", as:"signup"
  post"/create",to:"user#create",as:"create"
  get "/index", to:"home#index",as:"race_index"
  resources:user

  get '/uma_index',to:'uma#index',as:'uma_index'
  get '/uma_show/:link',to:'uma#show',as:'uma_show'
  get '/uma_detail/:name',to:'uma#detail',as:'uma_detail'
  get 'uma/search' => 'uma#search',as:'search'
  resources:uma, params: :name
  
  resources :uma do
    post '/add', to:'favorite#create'
    post'/add/:id' ,to:'favorite#update', as:'favorite_update'
    delete '/add', to:'favorite#destroy'
  end
  
  get '/race_index', to:'race#index', as:'race_index_next'
  get '/race_info/:name', to:'race#info', as:'race_info'
  # get 'race_detail/:name',to:'race#detail',as:'race_detail'
  get '/race_show/:name', to:'race#show', as:'race_show'
  get '/race_run/:name', to:'race#run', as:'race_run'
  get '/race_result/:name', to:'race#result', as:'race_result'
  resources:race, params: :name

  #   resources :race do
  #   post '/add', to:'myrace#create'
  #   post'/add/:id' ,to:'myrace#update', as:'myrace_update'
  #   delete '/add', to:'myrace#destroy'
  # end


  get '/couse', to:'couse#index', as:'couse_index'
    post '/couse',to:'couse#create'
  

end
