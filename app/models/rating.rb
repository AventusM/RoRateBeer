class Rating < ApplicationRecord
  belongs_to :beer
  belongs_to :user # Käyttäjä luo arvostelun

  validates :score, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 50, only_integer: true } # Annetun arvostelun pistemäärän validointia
  
  # Muoto https://stackoverflow.com/questions/28459943/using-a-scope-with-last-is-returning-an-associationrelation-in-view
  scope :recent, -> {order(created_at: :desc).limit(5)}

  # "puts" helvettii täältä nii alkaa näkyy jo jotain -.-
  def to_s
    # beer_by_beer_id = Beer.find_by(id: self.beer_id)

    # Unohdin rails-taian ...
    # Rating has one beer -> self.beer.param (self redundant per rubocop)
    "#{beer.name} #{score}"
  end
end
