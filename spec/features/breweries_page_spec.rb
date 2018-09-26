require 'rails_helper'

describe("Breweries page") do
  it("should not have any breweries by default") do
    visit(breweries_path)
    # puts page.html
    expect(page).to(have_content("Breweries"))
    expect(page).to(have_content("Amount of breweries – 0"))
  end

  describe("Breweries") do

    # Tämän lohkon sisällä muuttujat @ - muotoon
    before :each do
      @brewery_names_array = ["Koff", "Heineken", "Karjala"]
      @brewery_names_array.each do |brew_name|
        FactoryBot.create(:brewery, name: brew_name) # Overriding default name
      end

      visit(breweries_path) # Before scope
    end

    it("lists existing breweries and their basic properties") do
      # brewery_names_array = ["Koff", "Heineken", "Karjala"]
      # brewery_names_array.each do |brew_name|
        # FactoryBot.create(:brewery, name: brew_name) # Overriding default name
      # end
      # visit(breweries_path)
      expect(page).to(have_content("Amount of breweries – #{@brewery_names_array.count}"))
      save_and_open_page
      @brewery_names_array.each do |brew_name|
        expect(page).to(have_content(brew_name))
      end
    end

    it("allows for brewery page navigation") do
      click_link("Heineken")
      save_and_open_page
      expect(page).to(have_content("Heineken"))
    end
  end

  # it("lists existing breweries and their basic properties") do
  #   # brewery_names_array = ["Koff", "Heineken", "Karjala"]
  #   # brewery_names_array.each do |brew_name|
  #     # FactoryBot.create(:brewery, name: brew_name) # Overriding default name
  #   # end
  #   # visit(breweries_path)
  #   expect(page).to(have_content("Amount of breweries – #{@brewery_names_array.count}"))
  #   save_and_open_page
  #   @brewery_names_array.each do |brew_name|
  #     expect(page).to(have_content(brew_name))
  #   end
  # end

  # it("allows for brewery navigation") do
  #   brewery_names_array = ["Koff", "Heineken", "Karjala"]
  #   brewery_names_array.each do |brew_name|
  #     FactoryBot.create(:brewery, name: brew_name) # Overriding default name
  #   end
  #   visit(breweries_path)
  #   click_link("Heineken")
  #   save_and_open_page

  #   expect(page).to(have_content("Heineken"))
  # end
end