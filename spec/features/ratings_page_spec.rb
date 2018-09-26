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
end