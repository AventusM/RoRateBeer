class Beer < ApplicationRecord
  belongs_to :brewery
  has_many :ratings

  def average_rating
    sum = 0
    self.ratings.each{ |rating| sum += rating.score }
    average = sum / (self.ratings.count * 1.0)
    "Has #{self.ratings.count} ratings, average #{average}"
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
