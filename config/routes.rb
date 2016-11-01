Rails.application.routes.draw do
  root to: 'homepages#search'

  get 'results' => 'homepages#index', as: 'results'

  get '/show/:name' => 'homepages#show', as: 'show_recipe'
  
end
