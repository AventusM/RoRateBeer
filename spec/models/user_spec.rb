require 'rails_helper'

RSpec.describe User, type: :model do
  # it("has the username set correctly") do
  #   user = User.new(username: "Anton")
  #   expect(user.username).to(eq("Anton")) # eq - metodi käytössä, kun tarkistetaan olioiden sisältöjä
  #   # expect(user.username).to(be("Anton")) # Ei toimi, be - metodilla verrataan kahden olion olevan sama
  # end

  # it("doesnt save a user without a password") do
  #   user = User.create(username: "Anton") # HUOM EI NEW
  #   # expect(user.valid?).to(be(false))
  #   expect(user).not_to(be_valid) # Sama kuin ylläoleva
  #   expect(User.count).not_to(eq(1)) # Yhtä käyttäjää ei lisätty (lähtökohta 0 tässä)
  # end

  # it("is saved with complete and proper sign-up info") do
  #   user = User.create(username: "Anton", password: "Test123", password_confirmation: "Test123")
  #   expect(user).to(be_valid)
  #   expect(User.count).to(eq(1)) # Yksi käyttäjä lisätty onnistuneesti
  # end

  # it("is saved with complete and proper sign-up info and displaying ratings") do
  #   user = User.create(username: "Anton", password: "Test123", password_confirmation: "Test123")
  #   expect(user).to(be_valid)
  #   expect(User.count).to(eq(1)) # Yksi käyttäjä lisätty onnistuneesti
  # end

  # it("displays ratings for created user along with valid brewery and beer") do
  #   testUser = User.create(username: "Anton", password: "Test123", password_confirmation: "Test123") # Miksi tämä vaatii createn?

  #   # Mikä on CREATE ja NEW ero, jos testimetodit ym. toimivat ristiin?
  #   testBrewery = Brewery.new(name: "Test Brewery", year: 2000)
  #   testBeer = Beer.new(name: "Coors light", style: "Shit", brewery: testBrewery) # beer.brewery mandatory parameter
    
  #   # testRating1 = Rating.create(score: 10, beer: testBeer, user: testUser)
  #   testRating1 = Rating.create(score: 10, beer: testBeer, user: testUser)
  #   testRating2 = Rating.new(score: 10, beer: testBeer)
  #   # testUser.ratings << testRating1
  #   testUser.ratings << testRating2

  #   expect(testUser.ratings.count).to(eq(2))
  #   expect(testUser.average_rating).to(eq("Has 2 ratings, average 10.0")) # Muotoa muutettava ehkä? Materiaalissa luku suoraan, oma metodi kaivannee muutosta
  # end

  # # Testausta describellä copypasten eliminoimiseksi
  # describe("with a proper user, brewery and beer") do
  #   # TÄRKEÄ HUOMIO --- muuttujien nimeäminen aaa_bbb_ccc tyyliin, EI CAMELCASE
  #   # TÄRKEÄ HUOMIO --- muuttujien nimeäminen aaa_bbb_ccc tyyliin, EI CAMELCASE
  #   # TÄRKEÄ HUOMIO --- muuttujien nimeäminen aaa_bbb_ccc tyyliin, EI CAMELCASE
  #   # TÄRKEÄ HUOMIO --- muuttujien nimeäminen aaa_bbb_ccc tyyliin, EI CAMELCASE
  #   # Seurauksena esim User.count ei ole 1, jos laittaa let(:testUser)
  #   let(:test_user){User.create(username: "Anton", password: "Test123", password_confirmation: "Test123")}
  #   let(:test_brewery){Brewery.create(name: "Test Brewery", year: 2000)}
  #   let(:test_beer){Beer.create(name: "Coors light", style: "Shit", brewery: testBrewery)}
    
  #   it("saves a new user") do
  #     expect(test_user).to(be_valid)
  #     expect(User.count).to(eq(1))
  #   end
  # end

  it("doesnt create user with password consisting only of text") do
    invalid_user_1 = User.create(username: "Anton", password: "Test", password_confirmation: "Test")
    expect(invalid_user_1).not_to(be_valid)
    expect(User.count).to(eq(0))
  end
  it("doesnt create user with too short password") do
    invalid_user_2 = User.create(username: "Anton", password: "jE1", password_confirmation: "jE1")
    expect(invalid_user_2).not_to(be_valid)
    expect(User.count).to(eq(0))
  end
end
