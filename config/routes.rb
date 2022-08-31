Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post '/weather/current', to: 'weather#create'
  # Defines the root path route ("/")
  # root "articles#index"
end
