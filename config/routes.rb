Rails.application.routes.draw do
  resources :beers
  resources :breweries
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # ROOT
  get('/', to: 'breweries#index')

  # REST Rating
  # GET
  get('ratings', to: 'ratings#index')
  get('ratings/new', to: 'ratings#new')
  # POST
  post('ratings', to: 'ratings#create')

  #vaihtoehtoisesti - root 'breweries#index'
  # get 'kaljat', to: 'beers#index'
end
