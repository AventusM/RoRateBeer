class Rating < ApplicationRecord
  belongs_to :beer

  # "puts" helvettii täältä nii alkaa näkyy jo jotain -.-
  def to_s
    # beer_by_beer_id = Beer.find_by(id: self.beer_id)

    # Unohdin rails-taian ...
    # Rating has one beer -> self.beer.param (self redundant per rubocop)
    "#{beer.name} #{score}"
  end
end
