Rails.application.routes.draw do
  root to: 'homepages#search'

  get 'results' => 'homepages#index', as: 'results'

  get '/show/:label' => 'homepages#show', as: 'show_recipe'

  get 'back' => 'homepages#back', as: 'back'

  get 'next' => 'homepages#next', as: 'next'
end
