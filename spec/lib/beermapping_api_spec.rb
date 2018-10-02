require 'rails_helper'

describe "BeermappingApi" do
  it "When HTTP GET returns one entry, it is parsed and returned" do

    canned_answer = 
    <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>18856</id><name>Panimoravintola Koulu</name><status>Brewpub</status><reviewlink>https://beermapping.com/location/18856</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=18856&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=18856&amp;d=1&amp;type=norm</blogmap><street>Eerikinkatu 18</street><city>Turku</city><state></state><zip>20100</zip><country>Finland</country><phone>(02) 274 5757</phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*espoo/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeermappingApi.places_in("espoo")
    # puts places
    expect(places.size).to(eq(1))
    place = places.first
    expect(place.name).to(eq("Panimoravintola Koulu"))
    expect(place.street).to(eq("Eerikinkatu 18"))
  end

  it("when HTTP GET returns no entries, an empty array is returned instead") do
    canned_answer = 
    <<-END_OF_STRING
    <?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id></id><name></name><status></status><reviewlink></reviewlink><proxylink></proxylink><blogmap></blogmap><street></street><city></city><state></state><zip></zip><country></country><phone></phone><overall></overall><imagecount></imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*murmansk/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })
    places_response = BeermappingApi.places_in("murmansk")
    empty_array = []
    expect(places_response).to(eq(empty_array))
  end

  it("when HTTP GET returns multiple entries, they are parsed and returned as an array") do
    canned_answer = 
    <<-END_OF_STRING
    <?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>21528</id><name>Maistila</name><status>Brewery</status><reviewlink>https://beermapping.com/location/21528</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=21528&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=21528&amp;d=1&amp;type=norm</blogmap><street>Kaarnatie 20</street><city>Oulu</city><state>Oulun Laani</state><zip>90530</zip><country>Finland</country><phone>044 291 9589</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>21547</id><name>Sonnisaari</name><status>Brewery</status><reviewlink>https://beermapping.com/location/21547</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=21547&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=21547&amp;d=1&amp;type=norm</blogmap><street>Tuotekuja 1</street><city>Oulu</city><state>Oulun Laani</state><zip>90410</zip><country>Finland</country><phone></phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*oulu/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })
    places_response = BeermappingApi.places_in("oulu")

    expect(places_response.size).to(eq(2))
    first = places_response.first
    second = places_response.second

    expect(first.name).to(eq("Maistila"))
    expect(first.state).to(eq("Oulun Laani"))

    expect(second.name).to(eq("Sonnisaari"))
    expect(second.country).to(eq("Finland"))

    expect(places_response).to(eq([first, second]))

  end

end