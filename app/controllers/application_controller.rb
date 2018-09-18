class ApplicationController < ActionController::Base

  # Kaikki kontrollerit perivät tämän luokan -> määritellään metodi helper_metodiksi, niin myös näkymät voivat hyödyntää näitä
  # Tämän avulla tietokantakyselyitä ym. ei tehdä enää näkymässä
  helper_method :current_user

  # Navbar layout - palauttaa nil, jos ei sessionin user it:tä, muuten palautetaan löydetty käyttäjä
  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end
end
