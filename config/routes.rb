Rails.application.routes.draw do
  resources :users
  resources :beers
  resources :breweries

  # TÄMÄ KORVAA REST CRUDIN
  resources :ratings, only: [:index, :new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # HUOM resource (ts. vain 1 sessio kerrallaan) -- uusi sessio --> sessioN/new
  # CONTROLLER JA NÄKYMÄTIEDOSTOJEN NIMET SILTI SESSIONSSSSSSSSSS
  resource :session, only: [:new, :create, :destroy]

  # ROOT
  get('/', to: 'breweries#index')

  # SIGN UP
  get('signup', to: 'users#new')

  # REST Rating
  # GET
  # get('ratings', to: 'ratings#index')
  # get('ratings/new', to: 'ratings#new')
  # POST
  # post('ratings', to: 'ratings#create')

  #vaihtoehtoisesti - root 'breweries#index'
  # get 'kaljat', to: 'beers#index'
end
