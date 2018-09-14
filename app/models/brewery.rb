class Brewery < ApplicationRecord
  has_many :beers, dependent: :destroy # Panimoon liittyvät oluet poistetaan oluen poistamisessa (+ siihen liittyvät ratingit)
  has_many :ratings, through: :beers # Nyt myös panimo voi hyödyntää OMIEN OLUIDEN ratingeja (käytetään suoraan olut = Find_by(...) -> olut.ratings.count tms.)

  def average_rating
    ratings_amount = self.ratings.count # Tässä kuitenkin tulee KAIKKIEN OLUIDEN ratingimäärä
    average = self.ratings.inject(0.0){|sum,n| sum + n.score} / ratings_amount # use 0.0 as starter to have floats instead of multiplying by 1.0, sum is accumulator, n is a singular rating
    "Has #{ratings_amount} " + "rating".pluralize(ratings_amount) + ", average #{average}" # Tehtävä 6
  end
end
