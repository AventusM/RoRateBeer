class SessionsController < ApplicationController
  def new
    # Login page

  end

  def create
    # Kun sign-in/sign-up nappia painetaan
    user = User.find_by(username: params[:username])
    # Tarkistetaan, onko käyttäjää olemassa, jos ei niin redirect (saman sivun uudelleenlataus tässä tilanteessa)
    if user.nil?
      redirect_to(signin_path, notice: "User #{params[:username]} doesn't exist")
    else
    # raise
    # session saa user id:n löydetystä käyttäjästä
    session[:user_id] = user.id if user # Rubymainen muoto, tämä on selkein esimerkki materiaalista löytyneistä kamoista (not user.nil? - sijasta turha negaatio)
    # uudelleenohjaus omalle sivulle
    redirect_to(user_path(user.id), notice: "Welcome back!") # user_path users_pathin sijasta, koska mennään tietylle pathille(?)
    end
  end

  def destroy
    # logout / signout
    session[:user_id] = nil
    redirect_to(breweries_path) # root olemassa? ei -> päivitä, breweries_path vissiin root?
  end
end