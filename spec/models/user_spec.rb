require 'rails_helper'

# APUMETODEJA
def create_beer_with_rating(object, score)
  beer = FactoryBot.create(:beer)
  FactoryBot.create(:rating, beer: beer, score: score, user: object[:user] )
  beer
end

def create_beers_with_many_ratings(object, *scores)
  scores.each do |score|
    create_beer_with_rating(object, score)
  end
end

# END APUMETODIT

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

  # describe("with a proper password") do
  #   let(:test_user) {FactoryBot.create(:user)}

  #   it("saves a new user") do
  #     expect(test_user).to(be_valid)
  #     expect(User.count).to(eq(1))
  #   end

  #   it("adds ratings succesfully to user") do
  #     FactoryBot.create(:rating, score: 45, user: test_user)
  #     expect(test_user.ratings.count).to(eq(1))
  #   end
  # end

  describe("favourite beer style") do
    let(:test_user){FactoryBot.create(:user)}

    it("has a method to determine favorite style") do
      expect(test_user).to(respond_to(:favorite_style))
    end

    it("has no favorite style without any beers") do
      expect(test_user.favorite_style).to(eq(nil))
    end
  end

  # describe("favourite beer") do
  #   # Jos laittaa tänne test_user = ... niin se tallettuu tietokantaan
  #   # Siis käytettävä let:iä describessä
  #   let(:test_user) {FactoryBot.create(:user)}

  #   it("has a method to determine a favourite beer") do
  #     expect(test_user).to(respond_to(:favorite_beer))
  #   end
  
  #   it("without ratings there is no favorite beer") do
  #     expect(test_user.favorite_beer).to(eq(nil)) # returns nil by default
  #   end


  #    it("returns the only rating, if there is one") do
  #     test_beer = FactoryBot.create(:beer)
  #     rating = FactoryBot.create(:rating, score: 30, beer: test_beer, user: test_user)
  #     expect(test_user.favorite_beer).to(eq(test_beer)) 
  #   end

  #   it("returns the most highest rated one if several choices are present") do
  #     # test_beer1 = FactoryBot.create(:beer)
  #     # test_beer2 = FactoryBot.create(:beer)
  #     # test_beer3 = FactoryBot.create(:beer)
  #     # test_rating1 = FactoryBot.create(:rating, score: 10, beer: test_beer1, user: test_user)
  #     # test_rating2 = FactoryBot.create(:rating, score: 20, beer: test_beer2, user: test_user)
  #     # test_rating3 = FactoryBot.create(:rating, score: 30, beer: test_beer3, user: test_user)

  #     # expect(test_user.favorite_beer).to(eq(test_beer3))
  #     # create_beer_with_rating({user: test_user}, 10)
  #     # create_beer_with_rating({user: test_user}, 20)
  #     create_beers_with_many_ratings({user: test_user}, 10, 20, 25)
  #     best_beer = create_beer_with_rating({user: test_user}, 30)
  #     expect(test_user.favorite_beer).to(eq(best_beer))
  #   end
  # end
  # # Testausta describellä copypasten eliminoimiseksi
  # describe("with a proper user, brewery and beer") do
  #   # TÄRKEÄ HUOMIO --- muuttujien nimeäminen aaa_bbb_ccc tyyliin, EI CAMELCASE
  #   # Seurauksena esim User.count ei ole 1, jos laittaa let(:testUser)
  #   let(:test_user){FactoryBot.create(:user)}
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
