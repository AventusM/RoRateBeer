class RatingsController < ApplicationController
  def index
    @top_breweries = Brewery.top(3)
    @top_beers = Beer.top(3)
    @most_recent_ratings = Rating.recent
    @top_styles = Style.top(3)
    @top_users = User.top(3)
    # raise

    @ratings = Rating.all
    # Päästään käsiksi sivulle ratings.json ilman jbuilderin käyttöä näkymissä (joka on täyttä hepreaa btw)
    respond_to do |format|
      format.html { } # renderöidään oletusarvoinen template
      format.json { render json: @ratings }
    end
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
    @rating = Rating.create(params.require(:rating).permit(:beer_id, :score))
    
    # IMPORTANT
    # IMPORTANT
    # IMPORTANT
    # IMPORTANT
    @rating.user = current_user # Jokaisella ratingilla on oltava sen lisääjä (has_many) => liitetään arvostelu käyttäjään tässä
    # IMPORTANT
    # IMPORTANT
    # IMPORTANT
    # IMPORTANT

    # Redirect luonnin jälkeen
    if(@rating.save) # @rating.save Tallennetaan explisiittisesti edellinen muutos
      redirect_to(user_path(current_user.id))
    else # Ei redirectausta (virheilmoitusten näyttämistä varten)
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    # raise # params[:id] -> id ja poistettava rating saadaan hakemalla se erikseen
    rating_to_delete = Rating.find(params[:id])
    # puts rating_to_delete.user.username
    rating_to_delete.delete if current_user = rating_to_delete.user # Suoritetaan löydetyn ratingin poisto (NYT VAIN OMAT, ohjelma kaatuu, jos yritetään muuten)
    redirect_to(user_path(current_user.id)) # 'POST':in tapainen tilanne. Siirrytään takaisin kirjautuneen käyttäjän sivulle.
  end
end
