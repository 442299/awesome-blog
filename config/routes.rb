Rails.application.routes.draw do

  get 'sessions/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "staticpages#home"
  get "/about", to: "staticpages#about"
  get "/signup",to: "users#new"
  get "/login", to: "sessions#new"
  delete "/logout", to: "sessions#destroy"
  
  get "users/:id/edit",to: "users#edit"
  get "/update",to: "users#update"

  resources :users
  resources :sessions, only: :create
  resources :microposts, only: :create
end
