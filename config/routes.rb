# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html  
  # Defines the root path route ("/")
  # root "articles#index"
  post '/weather/current', to: 'weather#create'
  get '/weather/current/result', to: 'weather#show'
end
