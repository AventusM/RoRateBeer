class Beer < ApplicationRecord
  include RatingAverage # DRY pois omaan moduuliinsa, metodi average_rating ei näköjään tarvitse parametrimuutoksia ym. vaan toimii ihan suoraan ??

  belongs_to :brewery
  has_many :ratings, dependent: :destroy # Nyt, jos jokin olut poistetaan, niin siihen liittyvät ratingit poistetaan myös (ratingeilla belongs_to: beer)

  def to_s
    "#{self.name} by #{self.brewery.name}"
  end

  def print_report
    #self = this
    puts "Beer name: #{self.name}"
    puts "Beer style: #{self.style}"
    puts "Produced by #{self.brewery.name}"
  end

  def change
    self.style = "Cider"
    puts "Bewerage style is now #{self.style}"
  end
end
