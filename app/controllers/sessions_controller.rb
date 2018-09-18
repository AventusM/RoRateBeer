class SessionsController < ApplicationController
  def new
    # Login page

  end

  def create
    # Kun sign-in/sign-up nappia painetaan
    user = User.find_by(username: params[:username])
    # raise
    # session saa user id:n löydetystä käyttäjästä
    session[:user_id] = user.id if user # Rubymainen muoto, tämä on selkein esimerkki materiaalista löytyneistä kamoista (not user.nil? - sijasta turha negaatio)
    # uudelleenohjaus omalle sivulle
    redirect_to(user_path(user.id)) # user_path users_pathin sijasta, koska mennään tietylle pathille(?)
  end

  def destroy
    # logout / signout
    session[:user_id] = nil
    redirect_to(root) # root olemassa? ei -> päivitä
  end
end