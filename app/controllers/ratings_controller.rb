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
   Rating.create(params.require(:rating).permit(:beer_id, :score))
   # Redirect luonnin jälkeen
   redirect_to(ratings_path)


   # redirect_to("http://www.cs.helsinki.fi") xd
  end

end