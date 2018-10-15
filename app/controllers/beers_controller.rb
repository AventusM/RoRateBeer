class BeersController < ApplicationController
  before_action :ensure_that_signed_in, except: [:index, :show] # HUOM WHITELIST!!!
  before_action :set_beer, only: [:show, :edit, :update, :destroy]

  # new, edit, create saavat alla olevan metodin sisällöt käyttöönsä näkymiin
  before_action :set_breweries_and_styles, only: [:new, :edit, :create]
  before_action :ensure_that_admin_does_operation, only: [:destroy]


  # GET /beers
  # GET /beers.json
  def index
    @beers = Beer.all

    order = params[:order] || 'name' # order nil? -> oletusarvoinen järjestys nimen mukaan
  
    @beers = case order
      when 'name' then @beers.sort_by{ |b| b.name }
      when 'brewery' then @beers.sort_by{ |b| b.brewery.name }
      when 'style' then @beers.sort_by{ |b| b.style.beer_style }
    end
  end

  # GET /beers/1
  # GET /beers/1.json

  # Sivulla mahdollisuus luoda uusi arvostelu
  def show
    @rating = Rating.new

    # @beer saadaan set_beeristä (before action sisältää shown)
    @rating.beer = @beer
  end

  # GET /beers/new
  def new
    @beer = Beer.new
    # @breweries = Brewery.all
    # @styles = ["Weizen", "Lager", "Pale ale", "IPA", "Porter", "Cider", "Vodka"]
  end

  # GET /beers/1/edit
  def edit
    # DRY rikottu - korjataan myöhemmin (jos jaksaa)
    # @breweries = Brewery.all
    # @styles = ["Weizen", "Lager", "Pale ale", "IPA", "Porter", "Cider", "Vodka"]
  end

  # POST /beers
  # POST /beers.json
  def create
    @beer = Beer.new(beer_params)

    respond_to do |format|
      if @beer.save
        format.html { redirect_to beers_path, notice: 'Beer was successfully created.' } # ei voi laittaa sulkeisiin ( ts. redirect_to(beers_path) ) --> johtunee format.html:n ominaisuuksista
        format.json { render :show, status: :created, location: @beer }
      else
        # RELOAD Breweries and styles in case of error
        # @breweries = Brewery.all
        # @styles = ["Weizen", "Lager", "Pale ale", "IPA", "Porter", "Cider", "Vodka"]
        format.html { render :new }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /beers/1
  # PATCH/PUT /beers/1.json
  def update
    # raise
    respond_to do |format|
      if @beer.update(beer_params)
        format.html { redirect_to @beer, notice: 'Beer was successfully updated.' }
        format.json { render :show, status: :ok, location: @beer }
      else
        format.html { render :edit }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beers/1
  # DELETE /beers/1.json
  def destroy
    @beer.destroy
    respond_to do |format|
      format.html { redirect_to beers_url, notice: 'Beer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_beer
    @beer = Beer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def beer_params
    params.require(:beer).permit(:name, :style_id, :brewery_id)
  end

  # Siirretään copypaste omaan metodiinsa - käyttö set_beerin tapaan - before_action + käyttö tietyille metodeille
  def set_breweries_and_styles
    @breweries = Brewery.all
    @styles = Style.all
    # @styles = ["Weizen", "Lager", "Pale ale", "IPA", "Porter", "Cider", "Vodka"]
  end

end
