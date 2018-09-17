class Beer < ApplicationRecord
  include RatingAverage # DRY pois omaan moduuliinsa, metodi average_rating ei näköjään tarvitse parametrimuutoksia ym. vaan toimii ihan suoraan ??

  belongs_to :brewery
  has_many :ratings, dependent: :destroy # Nyt, jos jokin olut poistetaan, niin siihen liittyvät ratingit poistetaan myös (ratingeilla belongs_to: beer)

  def to_s
    "#{name} by #{brewery.name}" # self redundantteja
  end

  def ratings_sum
    # ratings.map{ |rating| rating.score }.sum # rubocop ehdottaa korjaukseksi alempaa ratkaisua
    ratings.map{&:score}.sum # rubocop herjaa tästä gtfo TargetRubyVersion ym.
  end

  def ratings_avg
    # return 0 if ratings.empty? # Coffeescript tyylinen if
    if ratings.count == 0 # Javamainen ratkaisu
      return 0
    end
    ratings_sum / ratings.count.to_f
  end

  def print_report
    #self = this
    puts "Beer name: #{name}"
    puts "Beer style: #{style}"
    puts "Produced by #{brewery.name}"
  end

  def change
    style = "Cider"
    puts "Bewerage style is now #{style}"
  end
end
