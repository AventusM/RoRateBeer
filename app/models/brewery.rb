class Brewery < ApplicationRecord
  has_many :beers, dependent: :destroy # Panimoon liittyvät oluet poistetaan oluen poistamisessa (+ siihen liittyvät ratingit)
end
