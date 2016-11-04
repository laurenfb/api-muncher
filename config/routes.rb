Rails.application.routes.draw do
  root to: 'homepages#search'

  get 'results' => 'homepages#index', as: 'results'

  get '/show/:label' => 'homepages#show', as: 'show_recipe'

  get 'back' => 'homepages#index', as: 'back'

  get 'next' => 'homepages#index', as: 'next'
end
