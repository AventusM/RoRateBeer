class Beer < ApplicationRecord
  include RatingAverage # DRY pois omaan moduuliinsa, metodi average_rating ei näköjään tarvitse parametrimuutoksia ym. vaan toimii ihan suoraan ??

  # https://apidock.com/rails/v2.3.8/ActiveModel/Validations/ClassMethods/validates_presence_of
  validates_presence_of :name
  validates_presence_of :style

  belongs_to :brewery
  has_many :ratings, dependent: :destroy # Nyt, jos jokin olut poistetaan, niin siihen liittyvät ratingit poistetaan myös (ratingeilla belongs_to: beer)
  has_many :raters, through: :ratings, source: :user # Monesta-moneen-yhteys arvostelujen kautta käyttäjiin. Beer.users sijasta käytetään nimitystä Beer.raters, kun source: :user 
  
  belongs_to :style
  
  def to_s
    "#{name} by #{brewery.name}" # self redundantteja
  end

  def ratings_sum
    ratings.map{ |rating| rating.score }.sum # rubocop ehdottaa korjaukseksi alempaa ratkaisua
    # ratings.map{&:score}.sum # rubocop herjaa tästä gtfo TargetRubyVersion ym.
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
