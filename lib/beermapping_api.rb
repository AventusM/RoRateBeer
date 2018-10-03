class BeermappingApi

  def self.places_in(city)
    city = city.downcase # Parametri lowercaseen
    places = Rails.cache.read(city) # Luetaan keksit, löytyisikö olemassaolevaa tietoa
    return places if places # Muuttumaton viime kertaan JA TRUE? Palautetaan olemassaolevat tiedot
    
    # Muuten haetaan varsinaisesta metodista uusi data
    places = get_places_in(city)
    # Laitetaan haettu data välimuistiin
    # expires_in täältä https://api.rubyonrails.org/classes/ActiveSupport/Cache/Store.html#method-i-fetch
    Rails.cache.write(city, places, expires_in: 1.week)
    # palautetaan varsinaiset paikkatiedot (implicit return)
    places 
  end

  def self.get_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.map do | place |
      Place.new(place)
    end
  end

  # TODO - VÄLIMUISTISUORITUS EHKÄ?
  def self.get_place_info_by_id(id)
    url = "http://beermapping.com/webservice/locquery/#{key}"
    response = HTTParty.get("#{url}/#{id}")
    parsed_response = response.parsed_response["bmp_locations"]["location"]
    
    # Basic error handling? -- id is a number tms...
    return nil if parsed_response['id'] == '0' or parsed_response['name'] == 'No locations Found'
    place = Place.new(parsed_response)
  end

  def self.key
    api_key = "889f6d94eb4f0afa0c0c8f968e62a2b9"
    api_key # Implicit return
  end
end