require 'rails_helper'

describe "Places" do
  it("if one is returned by API, then it is shown on the page") do
    # places_in on määritellyn APIn apumetodi /lib - hakemistossa
    allow(BeermappingApi).to(receive(:places_in).with("Kumpula").and_return([Place.new(name: "Oljenkorsi", id: 1)]))
    visit(places_path)
    fill_in('city', with: "Kumpula")
    click_button("Search")
    # save_and_open_page

    expect(page).to(have_content("Oljenkorsi"))
  end

  it("if many are returned by API, then all of them are shown on the page") do
    first_place = Place.new(name: "Belge", id: 1)
    second_place = Place.new(name: "Kaisla", id: 2)
    third_place = Place.new(name: "Stadin panimo", id: 3)
    multiple_places_array =  [first_place, second_place, third_place]

    allow(BeermappingApi).to(receive(:places_in).with("Helsinki").and_return(multiple_places_array))

    visit(places_path)
    fill_in('city', with: "Helsinki")
    click_button("Search")
    # save_and_open_page
    
    multiple_places_array.each do |place|
      expect(page).to(have_content(place.name))
    end
  end

  it("if API returns an empty array, then it returns a notice") do
    city_name = "Random city"
    no_places_array = []
    allow(BeermappingApi).to(receive(:places_in).with(city_name).and_return(no_places_array))

    visit(places_path)
    fill_in('city', with: city_name)
    click_button("Search")
    # save_and_open_page
    expect(page).to(have_content("No locations in #{city_name}"))
  end
end