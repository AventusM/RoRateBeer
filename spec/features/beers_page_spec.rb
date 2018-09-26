require 'rails_helper'

# OMAT MODUULIT
require 'helpers' # helpers.rb
include Helpers # MYÖS MODUULI ITSE
# END OMAT MODUULIT

describe "Beer" do
  let!(:test_brewery){FactoryBot.create(:brewery, name: "Test Brewery")}

  before :each do
    visit(new_beer_path)
    # save_and_open_page
  end

  it("gets saved when it has a name") do
    fill_in("beer[name]", with: "TestBeer")
    click_button("Create Beer")
    # save_and_open_page
    expect(page).to(have_content("TestBeer"))
    expect(page).to(have_content("Beer was successfully created."))
    expect(Beer.count).to(eq(1))
  end

  it("doesnt save a beer with no name") do
    click_button("Create Beer")
    # save_and_open_page
    expect(page).to(have_content("1 error prohibited this beer from being saved:"))
    expect(page).to(have_content("Name can't be blank"))
    expect(Beer.count).to(eq(0))
  end

end