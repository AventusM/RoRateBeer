class Brewery < ApplicationRecord
  include RatingAverage

  has_many :beers, dependent: :destroy # Panimoon liittyvät oluet poistetaan oluen poistamisessa (+ siihen liittyvät ratingit)
  has_many :ratings, through: :beers # Nyt myös panimo voi hyödyntää OMIEN OLUIDEN ratingeja (käytetään suoraan olut = Find_by(...) -> olut.ratings.count tms.)

end
