class ApplicationController < ActionController::Base

  # Kaikki kontrollerit perivät tämän luokan -> määritellään metodi helper_metodiksi, niin myös näkymät voivat hyödyntää näitä
  # Tämän avulla tietokantakyselyitä ym. ei tehdä enää näkymässä
  helper_method :current_user
  helper_method :ensure_that_signed_in

  # Navbar layout - palauttaa nil, jos ei sessionin user it:tä, muuten palautetaan löydetty käyttäjä
  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end

  def ensure_that_signed_in
    redirect_to(signin_path, notice: 'pussy nigga') if current_user.nil?
  end
end
