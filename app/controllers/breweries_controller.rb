class BreweriesController < ApplicationController
  before_action :ensure_that_signed_in, except: [:index, :show]
  before_action :set_brewery, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate, only: [:destroy] # SAMA KUIN before_filter, autentikointi suoritetaan VAIN silloin, kun kutsutaan destroy-metodia

  # GET /breweries
  # GET /breweries.json
  def index
    @breweries = Brewery.all

    # render :panimot -- renderöi tiedoston views/breweries/panimot.html.erb (jos sellainen siis olemassa)
    render :index # renderöi hakemistossa view/breweries olevan näkymätemplaten index.html.erb
  end

  # GET /breweries/1
  # GET /breweries/1.json
  def show
    # Avataan kurssimateriaalin mukaisesti tämä auki (redundant)
    @brewery = Brewery.find(params[:id])
    render :show
  end

  # GET /breweries/new
  def new
    @brewery = Brewery.new
  end

  # GET /breweries/1/edit
  def edit
  end

  # POST /breweries
  # POST /breweries.json
  def create
    @brewery = Brewery.new(brewery_params)

    respond_to do |format|
      if @brewery.save
        format.html { redirect_to @brewery, notice: 'Brewery was successfully created.' }
        format.json { render :show, status: :created, location: @brewery }
      else
        format.html { render :new }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /breweries/1
  # PATCH/PUT /breweries/1.json
  def update
    respond_to do |format|
      if @brewery.update(brewery_params)
        format.html { redirect_to @brewery, notice: 'Brewery was successfully updated.' }
        format.json { render :show, status: :ok, location: @brewery }
      else
        format.html { render :edit }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /breweries/1
  # DELETE /breweries/1.json
  def destroy
    @brewery.destroy
    respond_to do |format|
      format.html { redirect_to breweries_url, notice: 'Brewery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private # rubocop herjaa jos ei riviä ylä- ja alapuolella

  # Use callbacks to share common setup or constraints between actions.
  def set_brewery
    @brewery = Brewery.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def brewery_params
    params.require(:brewery).permit(:name, :year)
  end

  # Luodaan autentikointi
  # def authenticate
  #   admin_accounts = { "anton" => "notna", "geir" => "rieg", "ravel" => "levar" }
  #   authenticate_or_request_with_http_basic do |username, password|
  #     # implicit return
  #     admin_accounts[username] == password # https://www.railstutorial.org/book/rails_flavored_ruby#sec-hashes_and_symbols miksi username eikä :username
  #   end
  # end
end
