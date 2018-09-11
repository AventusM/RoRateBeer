Rails.application.routes.draw do
  resources :beers
  resources :breweries
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get('/', to: 'breweries#index')
  get('ratings', to: 'ratings#index')
  #vaihtoehtoisesti - root 'breweries#index'
  # get 'kaljat', to: 'beers#index'
end
