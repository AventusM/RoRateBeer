Rails.application.routes.draw do
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries

  # TÄMÄ KORVAA REST CRUDIN
  resources :ratings, only: [:index, :new, :create, :destroy]
  resources :memberships, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # HUOM resource (ts. vain 1 sessio kerrallaan) -- uusi sessio --> sessioN/new
  # CONTROLLER JA NÄKYMÄTIEDOSTOJEN NIMET SILTI SESSIONSSSSSSSSSS
  resource :session, only: [:new, :create, :destroy]

  # ROOT
  get('/', to: 'breweries#index')

  # Sessionhallintaa
  get('signup', to: 'users#new')
  get('signin', to: 'sessions#new')
  delete('signout', to: 'sessions#destroy') # Parempi käytänne kuin GET tässä

  # REST Rating
  # GET
  # get('ratings', to: 'ratings#index')
  # get('ratings/new', to: 'ratings#new')
  # POST
  # post('ratings', to: 'ratings#create')

  #vaihtoehtoisesti - root 'breweries#index'
  # get 'kaljat', to: 'beers#index'
end
