class PlacesController < ApplicationController
  def index
    # raise
  end

  def search
    # Refaktoroitu hakuversio - sovelluslogiikka pois kontrollerista /lib - hakemistoon
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to(places_path, notice: "No locations in #{params[:city]}")
    else
      render :index
    end
  end

  # def search
  #   api_key = "889f6d94eb4f0afa0c0c8f968e62a2b9"
  #   url = "http://beermapping.com/webservice/loccity/#{api_key}/"
  #   # ERB::Util.url_encode(params...) poistaa välilyöntiongelman. Nyt esim Las Vegas ym toimii.
  #   res = HTTParty.get("#{url}#{ERB::Util.url_encode(params[:city])}")
  #   parsed_res = res.parsed_response
  #   bmp_locations = parsed_res["bmp_locations"] # HUOM ei :bmp_locations -- XML !!
  #   location_places = bmp_locations["location"] # EDELLEEN PARSITAAN XML:ää
    
  #   # Suora copypaste, aika haalea ymmärrys asian ymmärryksestä...
  #   if location_places.is_a?(Hash) and location_places['id'].nil?
  #     redirect_to places_path, notice: "No places in #{params[:city]}"
  #   else
  #     location_places = [location_places] if location_places.is_a?(Hash)
  #     @places = location_places.map do | location |
  #       Place.new(location)
  #     end
  #     render :index
  #   end
  #   # raise
  # end
end