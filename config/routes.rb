Rails.application.routes.draw do
  resources :styles
  resources :beer_clubs

  # Kutsuu metodia toggle_banned users-controllerissa
  resources :users do
    post 'toggle_banned'
  end

  resources :beers

  resources :breweries do
    post 'toggle_activity', on: :member
  end

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

  # 3rd party API (Beermapping)
  # Paikkaa 2 alempaa GETiä - nyt reititys onnistuu muodossa place_path(place.id) ym id.
  resources :places, only: [:index, :show]

  # get('places', to: 'places#index')
  # get('places/:id', to: 'places#show')
  post('places', to: 'places#search')

  # REST Rating
  # GET
  # get('ratings', to: 'ratings#index')
  # get('ratings/new', to: 'ratings#new')
  # POST
  # post('ratings', to: 'ratings#create')

  #vaihtoehtoisesti - root 'breweries#index'
  # get 'kaljat', to: 'beers#index'

  get('beerlist', to: 'beers#list')
  get('brewerylist', to: 'breweries#list')
end
