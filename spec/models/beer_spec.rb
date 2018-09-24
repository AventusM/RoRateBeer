require 'rails_helper'

RSpec.describe Beer, type: :model do

  it("saves a valid beer") do
    valid_brewery_baltika = Brewery.create(name: "Baltika", year: 1990)
    valid_beer = Beer.create(name: "New age Vodka", style: "Vodka", brewery: valid_brewery_baltika)
    
    expect(valid_beer).to(be_valid)
    expect(Beer.count).to(eq(1))
  end

  it("fails to save a beer without a name") do
    valid_brewery_baltika = Brewery.create(name: "Baltika", year: 1990)
    invalid_beer = Beer.create(style: "Vodka", brewery: valid_brewery_baltika)

    expect(invalid_beer).not_to(be_valid)
    expect(Beer.count).to(eq(0))
  end

  it("fails to save a beer with no chosen style") do
    valid_brewery_baltika = Brewery.create(name: "Baltika", year: 1990)
    invalid_beer = Beer.new(name: "New age Vodka", brewery: valid_brewery_baltika)

    expect(invalid_beer).not_to(be_valid)
    expect(Beer.count).to(eq(0))
  end

end
