class Style < ApplicationRecord
  has_many :beers

  def rating_sum
    # b.average_rating palauttaa taulukon
    # eli pitäisi käytännössä tehdä beers_sum.first, muuten sama
    beers.map{|b| b.ratings_sum}.sum
  end

  def rating_count
    # Lasketaan kunkin oluen ratingmäärä
    beers.map{|b| b.ratings.count}.sum
  end

  def rating_avg
    return 0 if rating_count == 0
    avg = rating_sum / rating_count
    avg.round(1)
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Style.all.sort_by{ |s| -(s.rating_avg || 0) }
    # palauta listalta parhaat n kappaletta
    # miten? ks. http://www.ruby-doc.org/core-2.5.1/Array.html
    sorted_by_rating_in_desc_order.take(n)
  end
end
