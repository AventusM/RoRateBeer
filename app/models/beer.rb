class Beer < ApplicationRecord
  belongs_to :brewery
  has_many :ratings

  def average_rating
    # YHTEINEN
    ratings_amount = self.ratings.count

    # TEHTÄVÄ 5
    # sum = 0
    # self.ratings.each{ |rating| sum+=rating.score } # Calculate sum
    # average = sum / (ratings_amount * 1.0)
    # "Has #{ratings_amount} ratings, average #{average}"

    # TEHTÄVÄ 6
    # No reduce for object straight up - have to use inject instead
    average = self.ratings.inject(0.0){|sum,n| sum + n.score} / ratings_amount # use 0.0 as starter to have floats instead of multiplying by 1.0, sum is accumulator, n is a singular rating
    "Has #{ratings_amount} " + "rating".pluralize(ratings_amount) + " average #{average}" # Tehtävä 6
  end

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
