class MembershipsController < ApplicationController
  # Olemassaoleva user id sessiosta - redirect jos ei ole + notice?
  # Param club id formista

  def new
    @membership = Membership.new
    all_clubs = BeerClub.all
    user_clubs = User.find(session[:user_id]).beer_clubs
    # raise
    @beer_clubs = all_clubs - user_clubs # https://stackoverflow.com/questions/32436091/filter-to-exclude-elements-from-array
    render :new
  end

  def create
    user_clubs = User.find(session[:user_id]).beer_clubs
    # Redirect etusivulle (breweries_pathin voisi laittaa rootiksi..), jos valitaan tyhjä TAI KIERRETÄÄN valinta client-sidelta, ehkä lisättävä notifikaatio?
    # Tällöin redirect muutettava toiseen muotoon (eli rubymainen if --> if{}then render this page with nofitications...)
    if(params[:membership].nil? || user_clubs.include?(BeerClub.find(params[:membership][:beer_club_id]))) # vastattu tyhjään tai client-side juttu kierretty..?
      return redirect_to(breweries_path)
    else
      @membership = Membership.create(params.require(:membership).permit(:beer_club_id)) # fieldin id:n tulee olla beer_club_id
      @membership.user_id = current_user.id
      @membership.save
      redirect_to(beer_club_path(@membership.beer_club_id), notice: 'Welcome to the club, ' + current_user.username + '!')
      # redirect_to(user_path(current_user.id))
    end
    # Redirect luonnin jälkeen noticen kanssa?
  end

  def destroy
    # @membership = current_user.id
    raise
  end
end