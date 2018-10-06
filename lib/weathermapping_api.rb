class WeathermappingApi

  def self.get_weather_info_in(city)
    city_format = city.downcase
    url = "http://api.apixu.com/v1/current.xml?key=#{api_key}&q="
    response = HTTParty.get("#{url}#{ERB::Util.url_encode(city_format)}")
    weather_info_from_api = response.parsed_response["root"]
    # raise

    return nil if weather_info_from_api["error"]
    weather = Weather.new(weather_info_from_api)
  end

  def self.api_key
    api_key = "d792a71a74a94133bc7144144180410"
    api_key
  end
end