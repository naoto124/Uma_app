Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root "home#top"

get "signup", to:"user#new", as:"singup"
post "signup", to: "user#create", as: "create"

end
