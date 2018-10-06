class PlacesController < ApplicationController
  before_action :find_place, only: [:show]

  def index
    # raise
  end

  def show
  end

  def search
    # Refaktoroitu hakuversio - sovelluslogiikka pois kontrollerista /lib - hakemistoon
    @places = BeermappingApi.places_in(params[:city])
    @weather = WeathermappingApi.get_weather_info_in(params[:city])
    # raise
    if @places.empty?
      redirect_to(places_path, notice: "No locations in #{params[:city]}")
    else
      render :index
    end
  end

  def find_place
    @place = BeermappingApi.get_place_info_by_id(params[:id])
    # raise
    if @place.nil?
      redirect_to(places_path, notice: "No place found with given id")
    else
      render :show
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