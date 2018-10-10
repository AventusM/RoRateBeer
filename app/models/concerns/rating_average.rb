module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    ratings_amount = ratings.count # self.ratings -> rubocop herjaa virhettä

    # Ei voida jakaa nollalla (NaN)
    return 0 if ratings_amount == 0
    average = ratings.inject(0.0){ |sum, n| sum + n.score } / ratings_amount # use 0.0 as starter to have floats instead of multiplying by 1.0. Sum is accumulator and n is a singular rating
    # "Has #{ratings_amount} " + "rating".pluralize(ratings_amount) + ", average #{average}" # Tehtävä 6
    average.round(1) # Saattaa rikkoa hieman ulkonäköä juuri nyt.. PYÖRISTETTY HIEMAN !!!
  end
end
