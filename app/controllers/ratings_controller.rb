class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
    render :index
  end

  def new
    @rating = Rating.new
    # Jotta voidaan hyödyntää kaljojen id:t valikoissa, tarvitaan olemassaolevat kaljat
    @beers = Beer.all
  end

  def create
    # raise # palauttaa paramit errorsivulla
    # byebug # muuttuja rating = params[:rating] -> rating[:score] tai rating[:beer_id] -- vaihtoehtoisesti params[:rating][:score] ym.
    # binding.pry -- vaihtoehto byebugille
    # Rating.create(params[:rating]) -- ei kelpaa
    rating = Rating.create(params.require(:rating).permit(:beer_id, :score))
    # Rails-magiaa taas -- :last_rating viimeisin luotu rating (ylläoleva)
    session[:last_rating] = "#{rating.beer.name} #{rating.score} points"
    # Redirect luonnin jälkeen
    redirect_to(ratings_path)
  end

  def destroy
    # raise # params[:id] -> id ja poistettava rating saadaan hakemalla se erikseen
    rating_to_delete = Rating.find(params[:id])
    rating_to_delete.delete # Suoritetaan löydetyn ratingin poisto
    redirect_to(ratings_path) # 'POST':in tapainen tilanne
  end
end
