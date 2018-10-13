class ApplicationController < ActionController::Base

  # Kaikki kontrollerit perivät tämän luokan -> määritellään metodi helper_metodiksi, niin myös näkymät voivat hyödyntää näitä
  # Tämän avulla tietokantakyselyitä ym. ei tehdä enää näkymässä
  helper_method :current_user
  helper_method :ensure_that_signed_in
  helper_method :blocked_to_join_club
  helper_method :ensure_that_admin_does_operation

  # Navbar layout - palauttaa nil, jos ei sessionin user it:tä, muuten palautetaan löydetty käyttäjä
  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end

  def blocked_to_join_club
    # Metodi suoritetaan yksittäisen beer_clubin sivulla. Tästä syystä saadaan id - parametrin käyttöön
    parsed_beer_club_id = Integer(params[:id])
    user_beer_club_ids = current_user.beer_club_ids


    user_beer_club_ids.include?(parsed_beer_club_id)
    # raise
    # return nil if current_user.beer_club_ids.include?(Integer(params[:id]))
  end

  def ensure_that_signed_in
    redirect_to(signin_path, notice: 'You need to be logged in to attempt this operation') if current_user.nil?
  end

  def ensure_that_admin_does_operation
    redirect_to(breweries_path, notice: 'Only administrators are allowed to do this operation') if (current_user.admin.nil? or (not current_user.admin))
  end
end
