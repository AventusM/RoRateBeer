class Beer < ApplicationRecord
  belongs_to :brewery
  has_many :ratings

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
