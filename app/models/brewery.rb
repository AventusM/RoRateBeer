class Brewery < ApplicationRecord
  include RatingAverage

  # https://apidock.com/rails/v2.3.8/ActiveModel/Validations/ClassMethods/validates_presence_of
  validates_presence_of :name
  validates :year, numericality: { greater_than_or_equal_to: 1040, only_integer: true }
  validates :year, numericality: { less_than_or_equal_to: -> (brewery) { Date.current.year }, only_integer: true }

  has_many :beers, dependent: :destroy # Panimoon liittyvät oluet poistetaan oluen poistamisessa (+ siihen liittyvät ratingit)
  has_many :ratings, through: :beers # Nyt myös panimo voi hyödyntää OMIEN OLUIDEN ratingeja (käytetään suoraan olut = Find_by(...) -> olut.ratings.count tms.)

  # Kontrollerit voivat hyödyntää näitä metodeja suoraan
  # sen sijaan, että kysely tehtäisiin siellä (+ DRY fix)
  # materiaalissa lukee allaoleva..
  # "modelin rooli on nimenomaan toimia abstraktiokerroksena muun sovelluksen ja tietokannan välillä."
  scope :active, -> {where active: true}
  scope :retired, -> {where active: [nil,false]}

  def self.top(n)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average_rating || 0) }
    # palauta listalta parhaat n kappaletta
    # miten? ks. http://www.ruby-doc.org/core-2.5.1/Array.html
    sorted_by_rating_in_desc_order.take(n)
  end
end
