module Helpers

  def sign_in(credentials)
    visit(signin_path)
    fill_in("username", with:credentials[:username])
    fill_in("password", with:credentials[:password])
    click_button("Log in")
  end

  def sign_up(credentials)
    visit(signup_path)
    fill_in("user[username]", with:credentials[:username])
    fill_in("user[password]", with:credentials[:password])
    fill_in("user[password_confirmation]", with:credentials[:password_confirmation])
    click_button("Create User")
  end

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
end