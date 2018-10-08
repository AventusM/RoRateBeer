# class MembershipsController < ApplicationController
#   # Olemassaoleva user id sessiosta - redirect jos ei ole + notice?
#   # Param club id formista

#   def new
#     @membership = Membership.new
#     all_clubs = BeerClub.all
#     user_clubs = User.find(session[:user_id]).beer_clubs
#     # raise
#     @beer_clubs = all_clubs - user_clubs # https://stackoverflow.com/questions/32436091/filter-to-exclude-elements-from-array
#     render :new
#   end

#   def create
#     user_clubs = User.find(session[:user_id]).beer_clubs
#     # Redirect etusivulle (breweries_pathin voisi laittaa rootiksi..), jos valitaan tyhjä TAI KIERRETÄÄN valinta client-sidelta, ehkä lisättävä notifikaatio?
#     # Tällöin redirect muutettava toiseen muotoon (eli rubymainen if --> if{}then render this page with nofitications...)
#     if(params[:membership].nil? || user_clubs.include?(BeerClub.find(params[:membership][:beer_club_id]))) # vastattu tyhjään tai client-side juttu kierretty..?
#       return redirect_to(breweries_path)
#     else
#       @membership = Membership.create(params.require(:membership).permit(:beer_club_id)) # fieldin id:n tulee olla beer_club_id
#       @membership.user_id = current_user.id
#       @membership.save
#       redirect_to(beer_club_path(@membership.beer_club_id), notice: 'Welcome to the club, ' + current_user.username + '!')
#       # redirect_to(user_path(current_user.id))
#     end
#     # Redirect luonnin jälkeen noticen kanssa?
#   end

#   def destroy
#     # @membership = current_user.id
#     raise
#   end
# end
class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]

  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
    @beer_clubs = BeerClub.all - current_user.beer_clubs
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships
  # POST /memberships.json
  def create
    @membership = Membership.new(membership_params)
    @membership.user = current_user

    respond_to do |format|
      if @membership.save
        format.html { redirect_to @membership.beer_club, notice: "#{current_user.username} welcome to the club!" }
        format.json { render :show, status: :created, location: @membership }
      else
        @beer_clubs = BeerClub.all - current_user.beer_clubs
        format.html { render :new }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to @membership.user, notice: "Membership in #{@membership.beer_club.name} ended" }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_membership
    @membership = Membership.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def membership_params
    params.require(:membership).permit(:beer_club_id, :user_id)
  end
end