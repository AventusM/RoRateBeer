require 'rails_helper'

describe "Beerlist page" do
  before :all do
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :chrome)
    end
    WebMock.disable_net_connect!(allow_localhost: true) # WebMock gem estää muuten testien suorituksen
  end

  before :each do
    @brewery1 = FactoryBot.create(:brewery, name:"Koff")
    @brewery2 = FactoryBot.create(:brewery, name:"Schlenkerla")
    @brewery3 = FactoryBot.create(:brewery, name:"Ayinger")
    @style1 = Style.create(beer_style:"Lager")
    @style2 = Style.create(beer_style:"Rauchbier")
    @style3 = Style.create(beer_style:"Weizen")
    @beer1 = FactoryBot.create(:beer, name:"Nikolai", brewery: @brewery1, style:@style1)
    @beer2 = FactoryBot.create(:beer, name:"Fastenbier", brewery:@brewery2, style:@style2)
    @beer3 = FactoryBot.create(:beer, name:"Lechte Weisse", brewery:@brewery3, style:@style3)
  end

  it("shows one known beer", js:true) do
    visit(beerlist_path)
    # find('table').find('tr:nth-child(2)')
    # save_and_open_page
    expect(page).to(have_content("Nikolai"))
  end

  it("should show beers in alphabet order by default", js:true) do
    visit(beerlist_path)

    first_name = find('table').find('tr:nth-child(2)').find('td:nth-child(1)')
    second_name = find('table').find('tr:nth-child(3)').find('td:nth-child(1)')
    third_name = find('table').find('tr:nth-child(4)').find('td:nth-child(1)')

    expect(first_name).to(have_content("Fastenbier"))
    expect(second_name).to(have_content("Lechte Weisse"))
    expect(third_name).to(have_content("Nikolai"))
  end

  it("shows beers in styles' alphabetic order when clicked on style link", js:true) do
    visit(beerlist_path)
    # save_and_open_page
    click_link("Style")
    # save_and_open_page

    first_style = find('table').find('tr:nth-child(2)').find('td:nth-child(2)')
    second_style = find('table').find('tr:nth-child(3)').find('td:nth-child(2)')
    third_style = find('table').find('tr:nth-child(4)').find('td:nth-child(2)')

    expect(first_style).to(have_content("Lager"))
    expect(second_style).to(have_content("Rauchbier"))
    expect(third_style).to(have_content("Weizen"))
  end

  it("shows beers in breweries' alphabetic order when clicked on brewery link", js:true) do
    visit(beerlist_path)
    # save_and_open_page
    click_link("Brewery")

    first_brewery = find('table').find('tr:nth-child(2)').find('td:nth-child(3)')
    second_brewery = find('table').find('tr:nth-child(3)').find('td:nth-child(3)')
    third_brewery = find('table').find('tr:nth-child(4)').find('td:nth-child(3)')

    expect(first_brewery).to(have_content("Ayinger"))
    expect(second_brewery).to(have_content("Koff"))
    expect(third_brewery).to(have_content("Schlenkerla"))
  end
end