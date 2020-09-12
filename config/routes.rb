Rails.application.routes.draw do
  root "home#top"

  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to:'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/signup", to:"user#new", as:"singup"
  post"/create",to:"user#create",as:"create"

end
