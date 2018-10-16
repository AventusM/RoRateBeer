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

    first_name_row = find('table').find('tr:nth-child(2)').find('td:nth-child(1)')
    second_name_row = find('table').find('tr:nth-child(3)').find('td:nth-child(1)')
    third_name_row = find('table').find('tr:nth-child(4)').find('td:nth-child(1)')
    
    expect(first_name_row).to(have_content("Fastenbier"))
    expect(second_name_row).to(have_content("Lechte Weisse"))
    expect(third_name_row).to(have_content("Nikolai"))
  end
end