require 'rails_helper'

# OMAT MODUULIT
require 'helpers' # helpers.rb
include Helpers # MYÖS MODUULI ITSE
# END OMAT MODUULIT

describe "Rating" do

  let!(:test_brewery){FactoryBot.create :brewery, name: "Heineken"}
  let!(:test_beer1){FactoryBot.create :beer, name: "Heineken Pilsener", brewery: test_brewery}
  let!(:test_beer2){FactoryBot.create :beer, name: "Heineken Lager beer", brewery: test_brewery}
  let!(:test_user){FactoryBot.create :user}
  let!(:test_user2){FactoryBot.create :user, username: "Geir"}

  before :each do
    sign_in(username: "Anton", password: "Test123") # Moduulissa helpers
  end

  it("is registered to both beer and the user who registered it") do
    visit(new_rating_path)
    select("Heineken Pilsener", from: "rating[beer_id]")
    fill_in('rating[score]', with: '40')
    click_button("Create Rating")

    expect(test_user.ratings.count).to(eq(1))
    expect(test_beer1.ratings.count).to(eq(1))
    expect(test_beer1.average_rating).to(eq("Has 1 rating, average 40.0"))
  end

  it("shown on index page and their overall amount") do
    create_beers_with_many_ratings({user: test_user}, 10, 20, 30)
    create_beers_with_many_ratings({user: test_user2}, 5, 15, 25)

    test_user_ratings = test_user.ratings
    test_user2_ratings = test_user2.ratings
    ratings_count = test_user_ratings.count + test_user2_ratings.count
    # puts test_user_ratings

    visit(ratings_path)
    # save_and_open_page

    test_user_ratings.each do |test_user_rating|
      # puts test_user_rating (to_s)
      expect(test_user_rating.user.username).to(eq(test_user.username))
      expect(page).to(have_content(test_user_rating))
    end

    test_user2_ratings.each do |test_user2_rating|
      expect(test_user2_rating.user.username).to(eq(test_user2.username))
      expect(page).to(have_content(test_user2_rating))
    end

    expect(page).to(have_content("Overall #{ratings_count} ratings"))
  end
end