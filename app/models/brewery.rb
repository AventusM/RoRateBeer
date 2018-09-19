class Brewery < ApplicationRecord
  include RatingAverage

  # https://apidock.com/rails/v2.3.8/ActiveModel/Validations/ClassMethods/validates_presence_of
  validates_presence_of :name
  validates :year, numericality: { greater_than_or_equal_to: 1040, less_than_or_equal_to: 2018, only_integer: true }

  has_many :beers, dependent: :destroy # Panimoon liittyvät oluet poistetaan oluen poistamisessa (+ siihen liittyvät ratingit)
  has_many :ratings, through: :beers # Nyt myös panimo voi hyödyntää OMIEN OLUIDEN ratingeja (käytetään suoraan olut = Find_by(...) -> olut.ratings.count tms.)
end
